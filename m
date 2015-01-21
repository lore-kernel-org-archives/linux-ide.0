From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH] SATA: OCTEON: support SATA on OCTEON platform
Date: Wed, 21 Jan 2015 09:17:31 -0800
Message-ID: <54BFDF2B.80708@caviumnetworks.com>
References: <1421681040-3392-1-git-send-email-aleksey.makarov@auriga.com> <20150119154357.GH21553@leverpostej> <54BD580C.6030701@gmail.com> <20150121165427.GA8722@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20150121165427.GA8722@leverpostej>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Mark Rutland <mark.rutland@arm.com>
Cc: David Daney <ddaney.cavm@gmail.com>, Aleksey Makarov <aleksey.makarov@auriga.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Daney <david.daney@cavium.com>, Anton Vorontsov <avorontsov@ru.mvista.com>, Vinita Gupta <vgupta@caviumnetworks.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Ralf Baechle <ralf@linux-mips.org>, Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On 01/21/2015 08:54 AM, Mark Rutland wrote:
> On Mon, Jan 19, 2015 at 07:16:28PM +0000, David Daney wrote:
[...]
>>>> @@ -67,6 +76,7 @@ static const struct of_device_id ahci_of_match[] = {
>>>>    	{ .compatible = "ibm,476gtr-ahci", },
>>>>    	{ .compatible = "snps,dwc-ahci", },
>>>>    	{ .compatible = "hisilicon,hisi-ahci", },
>>>> +	{ .compatible = "cavium,octeon-7130-ahci", },
>>>>    	{},
>>>
>>> I was under the impression that the strings other than "generic-ahci"
>>> were only for compatibility with existing DTBs. Why do we need to add
>>> new platform-specific strings here?
>>
>> Because it is an "existing DTB", The device tree doesn't contain the
>> compatible property of "generic-ahci", only "cavium,octeon-7130-ahci".
>
> While the DTB may already exist, the string "cavium,octeon-7130-ahci"
> isn't in mainline, and as far as I can see has never been supported.

There seems to be a disconnect here.  The DTB comes from the hardware 
boot environment.  The hardware is in some cases already deployed.  It 
is for all practical purposes, impossible to change the DTB.

The idea that the kernel source code controls the content of the device 
tree doesn't apply here.

> We
> _maintain_ support for existing DTBs, we don't just copy what some
> forked kernel happens to do.
>
> Trying to push that under the "don't break existing DTBs" rule is
> bending the definition.

The purpose of the kernel is to provide services on top of actual 
hardware.  In general, for a kernel driver to support any given device, 
it may have to add device specific identifiers, that correspond to the 
device, in the probing code.

David Daney

>
> Thanks,
> Mark.
>
>
