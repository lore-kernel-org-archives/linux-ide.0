From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ata_piix: fix pio/mwdma programming (for testing, don't
 apply)
Date: Sat, 03 Feb 2007 01:41:41 +0900
Message-ID: <45C369C5.5000201@gmail.com>
References: <20070202151856.GD1625@htj.dyndns.org> <45C359FC.2000601@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.227]:22883 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945950AbXBBQlr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 11:41:47 -0500
Received: by nz-out-0506.google.com with SMTP id s1so919271nze
        for <linux-ide@vger.kernel.org>; Fri, 02 Feb 2007 08:41:46 -0800 (PST)
In-Reply-To: <45C359FC.2000601@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: ahaas@airmail.net, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Sergei Shtylyov wrote:
>> +    /* PIO configuration clears DTE unconditionally.  It will be
>> +     * programmed in set_dmamode which is guaranteed to be called
>> +     * after set_piomode if any DMA mode is available.
>> +     */
> 
>    Actually, I think ata_timing_merge() should just be performed when
> setting MWDMA mode... This should be the right thing to do in most cases
> (however, this hardware has some complications in the form of only 2-bit
> wide active/recovery counts and 2 fast timing bank select bits)...

Yeap, that'll be nice.  Dunno whether modifying piix/ata_piix too much
would be a good idea tho considering the wide usage.

>>      pci_read_config_word(dev, master_port, &master_data);
>>      if (is_slave) {
>> +        /* clear TIME1|IE1|PPE1|DTE1 */
>> +        master_data &= 0xff0f;
> 
>    Yeah, I've fixed this oversight in piix.c...

Great, please consider updating ata_piix together next time.  libata can
really use some help from a someone who knows a lot about PATA including
mode programming.

>> +        if (ap->udma_mask) {
>> +            udma_enable &= ~(1 << devid);
>> +            pci_write_config_word(dev, master_port, master_data);
>> +        }
> 
>    I've also noticed that this is done at the end of piix_set_piomode()
> and I see no reason why.  Isn't it just a leftover from the piix.c
> brokenness?  This driver coupled PIO and UDMA timing updates for no
> conceivable reason?

In both mwdma and pio cases, they're just turning off UDMA.  Don't know
whether it's actually necessary but still afraid to change it unless
there is a good reason.

-- 
tejun
