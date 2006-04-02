From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/7] libata: implement ap->sata_spd_limit and helpers
Date: Sun, 2 Apr 2006 20:04:52 +0900
Message-ID: <20060402110452.GJ13172@htj.dyndns.org>
References: <11439680862635-git-send-email-htejun@gmail.com> <442FAAB5.30501@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.199]:21542 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932325AbWDBLE6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 07:04:58 -0400
Received: by zproxy.gmail.com with SMTP id o37so1458120nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 04:04:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <442FAAB5.30501@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

On Sun, Apr 02, 2006 at 06:43:01AM -0400, Jeff Garzik wrote:
> Tejun Heo wrote:
> >-	/* Issue phy wake/reset */
> >+	/* SATA spec says nothing about how to reconfigure spd.
> >+	 * Configuring before starting hardreset works for both of my
> >+	 * test cases - ICH7 AHCI and sil3124.  Configuring while phy
> >+	 * is off sounds nice but ICH7 chokes on that.  It preserves
> >+	 * configured value but does not apply it.
> >+	 */
> >+	ata_set_sata_spd(ap);
> >+
> >+	/* issue phy wake/reset */
> > 	scontrol = scr_read(ap, SCR_CONTROL);
> > 	scontrol = (scontrol & 0x0f0) | 0x301;
> > 	scr_write_flush(ap, SCR_CONTROL, scontrol);
> 
> This code is an example of configuring the phy while its off...  You put 
> the speed setting before the phy wake.
> 
> Everything else looks OK.
> 

This is embarrasing. :( I was being delusional.  I somehow thought
DET=1 was PHY off and DET=0 was wake.  I'll test with actual PHY off
(DET=2) and redo this patch.  Sorry about the confusion.

-- 
tejun
