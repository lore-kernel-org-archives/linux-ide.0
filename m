From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: SIL24: pcie_set_readrq 4096
Date: Thu, 22 Jul 2010 23:34:22 +0900
Message-ID: <AANLkTiltS3zLLSBgv_VNEXpQvEez2PpObhjmbcZxJ2c8@mail.gmail.com>
References: <AANLkTinMJktVl28m-mL8i9N8_Q9V471LV3XsxsZlLIp7@mail.gmail.com>
	<4C48452D.5070207@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <4C48452D.5070207@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com
List-Id: linux-ide@vger.kernel.org

On Thu, Jul 22, 2010 at 10:18 PM, Tejun Heo <tj@kernel.org> wrote:
> It's been a while since I read pci-e spec but IIUC readrq size and
> payload size are independent and if readrq is larger than payload siz=
e
> it's supposed to complete in multiple steps. =C2=A0I could be wrong t=
ho.
AFAIUI readrq size is independent and not greater than the max_payload =
size.
Payload size is what max a device can handle and readrq is what a devic=
e can
ask.
SIL24 does support 4096 and hence can set readrq to that limit, but if =
the
payload capacity of the RC is less than 4096, I am not sure if it is su=
pposed to
work.
