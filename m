From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Pioneer DVR-111 problems with DMA
Date: Tue, 19 Jun 2007 13:13:56 +0100
Message-ID: <20070619131356.20e2b2c7@the-village.bc.nu>
References: <560608.38945.qm@web54404.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60112 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756892AbXFSMIV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Jun 2007 08:08:21 -0400
In-Reply-To: <560608.38945.qm@web54404.mail.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vlad <vladc6@yahoo.com>
Cc: linux-ide@vger.kernel.org, amills@acpmagazines.com.au

On Tue, 19 Jun 2007 01:55:38 -0700 (PDT)
Vlad <vladc6@yahoo.com> wrote:
> I'd like to bring to your attention an article that claims the Pioneer
> DVR-111 drive doesn't work with libata because the drive needs the
> nodma option:
> 
> http://apcmag.com/6415/first_look_at_fedora_core_7
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=242956
> 
> The drive was released recently (around 2006). Perhaps it should be
> added to the blacklist?

The blacklist is for specific drive problems. At the moment I see no
evidence the Pioneer problem is that. 
