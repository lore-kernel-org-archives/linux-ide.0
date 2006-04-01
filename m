From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] libata: prep for new EH
Date: Sat, 1 Apr 2006 19:51:48 +0900
Message-ID: <20060401105148.GH13172@htj.dyndns.org>
References: <11438885151530-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.192]:23597 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751507AbWDAKvx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Apr 2006 05:51:53 -0500
Received: by zproxy.gmail.com with SMTP id o37so1210850nzf
        for <linux-ide@vger.kernel.org>; Sat, 01 Apr 2006 02:51:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <11438885151530-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

On Sat, Apr 01, 2006 at 07:48:36PM +0900, Tejun Heo wrote:
> Hello, Jeff, Alan and Albert.
> 
> This patchset contains various fixes and updates in preparation for
> new EH.  Most patches are straight-forward and even trivial.
> 
> This patchset has 15 patches and is against

 14, obviously.  I was counting the scsi_eh_schdule() patch I've just
sent.  BTW, that SCSI patch and this patchset are the last ones before
the real EH patchset.  So, there now remain only two more patchsets -
the actual EH patchset and NCQ patchset.  I think I'll be able to post
both of them before monday.

Thanks.

-- 
tejun
