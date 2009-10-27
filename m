From: Mark Nelson <mdnelson8@gmail.com>
Subject: Re: [PATCH] ahci: Enable SB600 64bit DMA on MSI K9A2 Platinum
Date: Wed, 28 Oct 2009 09:51:36 +1100
Message-ID: <65a6ef750910271551i47858982xd1138e4a70a1b076@mail.gmail.com>
References: <65a6ef750910252203s58af446fv268c857191e698d3@mail.gmail.com>
	 <4AE5A330.3080506@kernel.org>
	 <65a6ef750910261605q45a08791h53cc2afd5d006bb3@mail.gmail.com>
	 <4AE7382F.20302@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f208.google.com ([209.85.219.208]:49148 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754237AbZJ0Wvd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Oct 2009 18:51:33 -0400
Received: by ewy4 with SMTP id 4so235465ewy.37
        for <linux-ide@vger.kernel.org>; Tue, 27 Oct 2009 15:51:36 -0700 (PDT)
In-Reply-To: <4AE7382F.20302@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, jeff@garzik.org

Adding back linux-ide and Jeff (accidentally dropped them off on my fir=
st reply)

On Wed, Oct 28, 2009 at 5:13 AM, Tejun Heo <tj@kernel.org> wrote:
> Hello, Mark.
>
> Mark Nelson wrote:
>>>From reading this bug report:
>> http://bugzilla.kernel.org/show_bug.cgi?id=3D14275
>> it sounds like when the SB600 can't do 64bit DMA the machine can fai=
l to boot.
>>
>> I've been using the system with a patch that removes the AHCI_HFLAG_=
32BIT_ONLY
>> from board_ahci_sb600 for a few months now, but the system only has =
4GB of RAM,
>> with some of it hoisted over the 32bit mark:
>>
>> Memory: 4048052k/4980736k available (2010k kernel code, 145176k
>> reserved, 922k data, 228k init)
>>
>> This probably isn't a rigorous enough test though... What is the bes=
t way to
>> verify it (and that way I can check more BIOS versions)?
>
> The surest way would be to put one time printk which prints out the
> physical dma address if it's above 4G in the issue path. =A0Something
> like the following (completely untested).
>
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index b1a2577..08b987d 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -2019,6 +2019,11 @@ static unsigned int ahci_fill_sg(struct ata_qu=
eued_cmd *qc, void *cmd_tbl)
> =A0 =A0 =A0 =A0for_each_sg(qc->sg, sg, qc->n_elem, si) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_addr_t addr =3D sg_dma_address(sg)=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 sg_len =3D sg_dma_len(sg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 static int cnt;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (addr > 0xffffffffULL && !(cnt++ % 5=
00))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("ahci: dma'ing t=
o address 0x%llx\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(unsigne=
d long long)addr);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ahci_sg[si].addr =3D cpu_to_le32(addr =
& 0xffffffff);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ahci_sg[si].addr_hi =3D cpu_to_le32((a=
ddr >> 16) >> 16);
>

That looks good. I'll have a play with it and see what I get.

Thanks!
Mark
