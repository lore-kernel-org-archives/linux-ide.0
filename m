From: Tejun Heo <tj@kernel.org>
Subject: Re: SIL24: pcie_set_readrq 4096
Date: Thu, 22 Jul 2010 22:42:38 +0200
Message-ID: <4C48AD3E.1060108@kernel.org>
References: <AANLkTinMJktVl28m-mL8i9N8_Q9V471LV3XsxsZlLIp7@mail.gmail.com>	<4C48452D.5070207@kernel.org> <AANLkTiltS3zLLSBgv_VNEXpQvEez2PpObhjmbcZxJ2c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <AANLkTiltS3zLLSBgv_VNEXpQvEez2PpObhjmbcZxJ2c8@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com
List-Id: linux-ide@vger.kernel.org

On 07/22/2010 04:34 PM, Jassi Brar wrote:
> On Thu, Jul 22, 2010 at 10:18 PM, Tejun Heo <tj@kernel.org> wrote:
>> It's been a while since I read pci-e spec but IIUC readrq size and
>> payload size are independent and if readrq is larger than payload size
>> it's supposed to complete in multiple steps.  I could be wrong tho.
> AFAIUI readrq size is independent and not greater than the max_payload size.
> Payload size is what max a device can handle and readrq is what a device can
> ask.
> SIL24 does support 4096 and hence can set readrq to that limit, but if the
> payload capacity of the RC is less than 4096, I am not sure if it is supposed to
> work.

Hmm... my impression is that a single read request may be served by
multiple TLPs, so readrq size can go over payload size which limits
the size of payload in a single TLP, but let's wait for someone more
knowledgeable to chime in.

Thanks.

-- 
tejun
