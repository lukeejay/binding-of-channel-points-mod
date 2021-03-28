import asyncio
import websockets


async def test():
    uri = "ws://localhost:8765"
    async with websockets.connect(uri) as websocket:
        code = input("Input code: ")

        await websocket.send(code)
        print(f"> {code}")

        aknowledge = await websocket.recv()
        print(f"< {aknowledge}")

        while True:
            next = await websocket.recv()
            print(f"< {next}")

asyncio.get_event_loop().run_until_complete(test())