From: Peng Ma <peng.ma@nxp.com>
Subject: RE: [EXT] Re: [v7 3/3] ahci: qoriq: add lx2160 platforms support
Date: Wed, 10 Apr 2019 02:34:50 +0000
Message-ID: <VI1PR04MB4431A5834D22040384C6B8D7ED2E0@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20190312015019.30628-1-peng.ma@nxp.com>
 <20190312015019.30628-3-peng.ma@nxp.com>
 <VI1PR04MB44310DDDF2D981F0BC0D7381ED2C0@VI1PR04MB4431.eurprd04.prod.outlook.com>
 <5bbd312c-6443-ea23-2b3e-97fd46a98a38@kernel.dk>
 <VI1PR04MB4431213C02A7DC614AB4E693ED2D0@VI1PR04MB4431.eurprd04.prod.outlook.com>
 <40cd2a5a-040c-9785-ee17-c5407a3872a7@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <40cd2a5a-040c-9785-ee17-c5407a3872a7@kernel.dk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Andy Tang <andy.tang@nxp.com>, Jianchao Wang <jianchao.wang@nxp.com>
List-Id: linux-ide@vger.kernel.org

SGkgQXhib2UsDQoNClRoYW5rcyB2ZXJ5IG11Y2guDQoNCkJlc3QgUmVnYXJkcywNClBlbmcNCg0K
Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogSmVucyBBeGJvZSA8YXhib2VAa2Vy
bmVsLmRrPg0KPlNlbnQ6IDIwMTnE6jTUwjnI1SAyMjoxNw0KPlRvOiBQZW5nIE1hIDxwZW5nLm1h
QG54cC5jb20+OyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+bWFyay5ydXRsYW5kQGFybS5jb207IHNo
YXduZ3VvQGtlcm5lbC5vcmc7IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPg0KPkNjOiBsaW51
eC1pZGVAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj5saW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7IEFuZHkgVGFuZw0KPjxhbmR5LnRhbmdAbnhwLmNvbT47IEppYW5jaGFvIFdhbmcgPGpp
YW5jaGFvLndhbmdAbnhwLmNvbT4NCj5TdWJqZWN0OiBSZTogW0VYVF0gUmU6IFt2NyAzLzNdIGFo
Y2k6IHFvcmlxOiBhZGQgbHgyMTYwIHBsYXRmb3JtcyBzdXBwb3J0DQo+DQo+V0FSTklORzogVGhp
cyBlbWFpbCB3YXMgY3JlYXRlZCBvdXRzaWRlIG9mIE5YUC4gRE8gTk9UIENMSUNLIGxpbmtzIG9y
DQo+YXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0
aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPg0KPk9uIDQvOS8xOSAxMjo0NCBBTSwgUGVuZyBN
YSB3cm90ZToNCj4+IEhpIEF4Ym9lLA0KPj4NCj4+IFBhdGNoIGxpbms6DQo+Pg0KPj4NCj5odHRw
czovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUy
RiUyRnBhdGNod28NCj5yay5vemxhYnMub3JnJTJGcGF0Y2glMkYxMDU1MDI4JTJGJmFtcDtkYXRh
PTAyJTdDMDElN0NwZW5nLm1hJTQwDQo+bnhwLmNvbSU3Q2U3NmJlNTM5YzI0YTQ3MzNjZjNmMDhk
NmJjZjYxOGRlJTdDNjg2ZWExZDNiYzJiNGM2ZmE5Mg0KPmNkOTljNWMzMDE2MzUlN0MwJTdDMSU3
QzYzNjkwNDE2MjUwNTUwMTUwMCZhbXA7c2RhdGE9QW03UUVKMlkNCj5zcWtOTFhVdElNWFUlMkZz
NU10NFFoellZYTFGamJoV2FBWGl3JTNEJmFtcDtyZXNlcnZlZD0wDQo+Pg0KPj4NCj5odHRwczov
L2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUy
RnBhdGNod28NCj5yay5vemxhYnMub3JnJTJGcGF0Y2glMkYxMDU0MTg5JTJGJmFtcDtkYXRhPTAy
JTdDMDElN0NwZW5nLm1hJTQwDQo+bnhwLmNvbSU3Q2U3NmJlNTM5YzI0YTQ3MzNjZjNmMDhkNmJj
ZjYxOGRlJTdDNjg2ZWExZDNiYzJiNGM2ZmE5Mg0KPmNkOTljNWMzMDE2MzUlN0MwJTdDMSU3QzYz
NjkwNDE2MjUwNTUwMTUwMCZhbXA7c2RhdGE9aWtwTkM0TSUNCj4yQkRxMyUyRlBZc1hMSGJQRGNE
dTJLZmdJUlhzJTJCakREWFd0cDJqayUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPg0KPkFwcGxpZWQsIHRo
YW5rcy4NCj4NCj4tLQ0KPkplbnMgQXhib2UNCg0K
