From: Hans Mueller <hans42mueller@googlemail.com>
Subject: Re: [Bug 16142] r8169: Kernel Panic when a lot of data is
 transferred through network interface
Date: Mon, 5 Jul 2010 13:44:01 +0200
Message-ID: <20100705134401.30c8112c@cbook>
References: <20100619100511.GA31429@liondog.tnic>
	<20100619132708.030fe408@cpc>
	<20100623080200.GB5010@liondog.tnic>
	<20100625185846.72171be0@cpc>
	<20100630065426.GA1857@liondog.tnic>
	<20100630200254.45ab84d1@cpc>
	<20100630183138.GA11036@liondog.tnic>
	<20100703094918.03007437@cbook.fritz.box>
	<20100703082304.GA25293@liondog.tnic>
	<20100703134149.63fd8c6d@cbook.fritz.box>
	<20100703115305.GA26168@liondog.tnic>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/cWsI_u6A/CL1YHJQxccmvNH"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43647 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920Ab0GELoK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jul 2010 07:44:10 -0400
Received: by bwz1 with SMTP id 1so2659682bwz.19
        for <linux-ide@vger.kernel.org>; Mon, 05 Jul 2010 04:44:08 -0700 (PDT)
In-Reply-To: <20100703115305.GA26168@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide <linux-ide@vger.kernel.org>

--MP_/cWsI_u6A/CL1YHJQxccmvNH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, 

even if this is quite offtopic and I'm not sure whether linux-ide
sould be still in the Cc field, I answert to all to leave nobody with
half of the story :)

On Sat, 3 Jul 2010 13:53:05 +0200
Borislav Petkov <bp@alien8.de> wrote:

> Did you also add the wireless maintainer to the Cc of your bugreport
> - "John W. Linville" <linville@tuxdriver.com>  [...]

No that is the only thing I did not. I followed the instructions from:
http://linuxwireless.org/en/users/Drivers/b43#bug_reporting
It wasn't mentioned to Cc anybody as far as I know :)



> [...] along with a detailed
> description of what the problem is, which kernel, how to reproduce along
> with dmesg?

I attached the text of the original mail (but not the attachments as
there should be no need for them in here; if I am wrong with this, ask
me for them :) )
If there is anything wrong with the bugreport, feel free to criticize.


I am aware that this is offtopic, so do not spend to much time
on it, I am going to send a copy of the original mail to the wireless
maintainer, as you suggested, and see what will happen.


Gruss / Regards,
Jonas
--MP_/cWsI_u6A/CL1YHJQxccmvNH
Content-Type: application/octet-stream; name=bugreport-mail
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=bugreport-mail

RnJvbTogSGFucyBNdWVsbGVyIDxIYW5zNDJNdWVsbGVyQGdvb2dsZW1haWwuY29tPgpUbzogYjQz
LWRldkBsaXN0cy5pbmZyYWRlYWQub3JnClN1YmplY3Q6IE9vcHMgb24gaWZjb25maWcgd2xhbjAg
dXAKRGF0ZTogU2F0LCAxOSBKdW4gMjAxMCAyMjoyOTozMCArMDIwMAoKCkhpLAoKSSBhbSB1c2lu
ZyBhbiBpYm9vayBnNCwgcnVubmluZyBnZW50b28gKGFuZCBNYWNPc1ggZm9yIHRlc3RpbmcpLgoK
RXZlcnkgdGltZSBJIHRyeSB0byB1c2UgbXkgd2lyZWxlc3MgY2FyZCwgdGhlIGRyaXZlciBjcmFz
aGVzLgonVXNpbmcnIG1lYW5zIHRvIGRvIHNvbWV0aGluZyBsaWtlICJpZmNvbmZpZyB3bGFuMCB1
cCIuIFNvbWV0aW1lcyB0aGUKZHJpdmVyIGFsc28gY3Jhc2hlcyB3aGlsZSBib290aW5nLgpJIHRy
aWVkIHRvIGJvb3QgTWFjT3NYLCBidXQgdGhlIHdsYW4gZGlkbid0IHdvcmsgdGhlcmUgYW55bW9y
ZSwgdG9vLgooTWFjT3NYIG5vdyBvZnRlbiBjcmFzaGVzIGFmdGVyIGEgZmV3IHNlY29uZHM7IG1p
Z2h0IHRoZQpkcml2ZXIgYnJva2UgbXkgd2xhbiBjYXJkPykKCgoKd2xhbiBjb25maWd1cmF0aW9u
LCBhdXRoZW50aWNhdGlvbi9lbmNyeXB0aW9uIHR5cGU6Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpub25lLCBpdCBjcmFzaGVzIHdpdGhvdXQgYmVp
bmcgY29ubmVjdGVkIHRvIGFueXRoaW5nCgoKdW5hbWUgLWE6Ci0tLS0tLS0tLQpMaW51eCBjYm9v
ayAyLjYuMzItZ2VudG9vLXI3ICM3IFN1biBNYXkgMzAgMTA6NDk6MTEgQ0VTVCAyMDEwCnBwYyA3
NDQ3QSwgYWx0aXZlYyBzdXBwb3J0ZWQgUG93ZXJCb29rNiw3IEdOVS9MaW51eAoKCndvcmtpbmcg
d2l0aCBvdGhlciBrZXJuZWwgdmVyc2lvbnM6Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCkkgZG9uJ3Qga25vdywgaXQgaXMgdGhlIGZpcnN0IGtlcm5lbCBJIHVzZSBvbiB0aGUg
aWJvb2sKCgpsc3BjaSAtdnZuIHwgZ3JlcCA0MyAtQTc6IGlzIGF0dGFjaGVkCgpkbWVzZzogaXMg
YXR0YWNoZWQgKGFuZCBjb250YWlucyB0aGUgT29wcyBtZXNzYWdlKQoKCi0tIApHcnXDny9SZWdh
cmRzLApKb25hcwoK

--MP_/cWsI_u6A/CL1YHJQxccmvNH--
