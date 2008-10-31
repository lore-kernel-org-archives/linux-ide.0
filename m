From: Phil Sutter <n0-1@freewrt.org>
Subject: Re: [PATCH] fix pata-rb532-cf
Date: Fri, 31 Oct 2008 01:09:12 +0100
Message-ID: <20081031000912.GB10620@nuty>
References: <1225403251-15705-1-git-send-email-n0-1@freewrt.org> <490A4156.5080302@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([81.169.176.177]:48604 "EHLO
	mail.ifyouseekate.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116AbYJaAIJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Oct 2008 20:08:09 -0400
Received: from nuty (localhost [127.0.0.1])
	by mail.ifyouseekate.net (Postfix) with ESMTP id 75DE138C5FB6
	for <linux-ide@vger.kernel.org>; Fri, 31 Oct 2008 01:08:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <490A4156.5080302@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

On Fri, Oct 31, 2008 at 02:20:54AM +0300, Sergei Shtylyov wrote:
>   Some of the changes look unneeded and some just strange...

you're completely right, my apologies for that.

> >-#define RB500_CF_REG_CMD	0x0800
> >+#define RB500_CF_REG_BASE	0x0800
> > #define RB500_CF_REG_CTRL	0x080E
> > #define RB500_CF_REG_DATA	0x0C00
> >+#define RB500_CF_REG_ERR	0x080D
> >  
> 
>   Hm...

The original driver (see my patch) accesses 0x80D to read error codes,
so I assumed this is correct. Indeed, the driver works also with the
standard setting. Is there a way I can clearly verify which is the right
offset?

> >-static void rb532_pata_data_xfer(struct ata_device *adev, unsigned char 
> >*buf,
> >+static unsigned int rb532_pata_data_xfer(struct ata_device *adev, 
> >unsigned char *buf,
> > 				unsigned int buflen, int write_data)
> > {
> > 	struct ata_port *ap = adev->link->ap;
> > 	void __iomem *ioaddr = ap->ioaddr.data_addr;
> >+	unsigned int ret = buflen;
> > 
> > 	if (write_data) {
> > 		for (; buflen > 0; buflen--, buf++)
> >@@ -87,6 +94,8 @@ static void rb532_pata_data_xfer(struct ata_device 
> >*adev, unsigned char *buf,
> > 	}
> > 
> > 	rb532_pata_finish_io(adev->link->ap);
> >+
> >+	return ret;
> >  
> 
>   Totally unneeded variable.

I wanted to preserve the behaviour of ata_sff_data_xfer(), i.e.
returning the number of bytes written. The variable exists, because
buflen is being decremented in the loop and therefore zero afterwards.
Returning a static value also should be no alternative, as it could lead
to unexpected behaviour on the caller side. So, do I miss something?

Greetings, Phil
