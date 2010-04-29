From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: SATA driver sata_sil24
Date: Thu, 29 Apr 2010 08:43:46 -0600
Message-ID: <x2y51f3faa71004290743pd2c82f96pe4e7df330cc58b45@mail.gmail.com>
References: <20100422083226.GA6018@crow.mawsonit.co.uk>
	 <20100422121747.GC6018@crow.mawsonit.co.uk> <4BD05043.10709@gmail.com>
	 <20100422223309.GA1883@crow.mawsonit.co.uk>
	 <4BD1129E.6030104@gmail.com>
	 <20100423203446.GF1883@crow.mawsonit.co.uk>
	 <y2i51f3faa71004231734hbcda3ad5p61798db712cc87c5@mail.gmail.com>
	 <20100424051021.GG1883@crow.mawsonit.co.uk>
	 <4BD58009.40202@seoss.co.uk>
	 <20100429091436.GO5360@crow.mawsonit.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f195.google.com ([209.85.221.195]:33821 "EHLO
	mail-qy0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755716Ab0D3WMM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Apr 2010 18:12:12 -0400
Received: by qyk33 with SMTP id 33so900111qyk.24
        for <linux-ide@vger.kernel.org>; Fri, 30 Apr 2010 15:12:11 -0700 (PDT)
In-Reply-To: <20100429091436.GO5360@crow.mawsonit.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Mawson <richard@crow.mawsonit.co.uk>
Cc: Tim Small <tim@seoss.co.uk>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Thu, Apr 29, 2010 at 3:14 AM, Richard Mawson
<richard@crow.mawsonit.co.uk> wrote:
> Tim,
>
> On Mon, Apr 26, 2010 at 12:59:05PM +0100, Tim Small wrote:
>> If you want to try to debug this further - you could turn on PCI par=
ity
>> error detection (either using EDAC module, or via userspace with
>> lspci/setpci)?
>>
>> # modprobe =A0edac_core
>> # echo 1 > /sys/module/edac_core/parameters/check_pci_errors
>>
>> If you're after a different solution for that machine, you can buy S=
ii
>> 3124 based cards (PCI-X to 4x SATA) for about the same price as that
>> adaptor....
>>
>> http://www.siliconimage.com/products/product.aspx?pid=3D27
>
> Thanks for your suggestions.
>
> I'm not too familiar with debugging pci errors, but I'm willing to tr=
y things
> out if there are suggestions as to what to look for.
>
> Having moves this to another system, still using the pci-pcie bridge,=
 there
> are problems too -- it just takes longer to show up. The system locks=
 up when
> copying large quantities of data to the disks.
>
> The symptom is the following code in the interrupt handler being call=
ed many
> many times:
>
> =A0 =A0 =A0 =A0if (status =3D=3D 0xffffffff) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR DRV_NAME ": IRQ status=
 =3D=3D 0xffffffff, "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "PCI fault or device remo=
val?\n");
>
> Does this indicate a hardware error? Is there a safe way to reset the=
 device
> in this state to avoid the repeated calls to the interrupt handler th=
at I
> suspect is the cause of the machine being unresponsive?
>
> I'm looking into pci debugging techniques, but any pointers would be =
welcome.

Register reads returning all 1s would indicate that there are likely
PCI aborts happening - could be either the bridge or the chip itself
has stopped responding.
