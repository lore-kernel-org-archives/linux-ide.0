From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.19-rc5: known regressions with patches
Date: Mon, 13 Nov 2006 21:35:58 -0500
Message-ID: <45592B8E.1020600@pobox.com>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org> <20061113221446.GJ22565@stusta.de> <4558F833.4090204@us.ibm.com> <Pine.LNX.4.64.0611131514190.22714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:31910 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S933336AbWKNCgM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Nov 2006 21:36:12 -0500
In-Reply-To: <Pine.LNX.4.64.0611131514190.22714@g5.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Brian King <brking@us.ibm.com>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>, linux-ide@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 13 Nov 2006, Brian King wrote:
> 
>> Adrian Bunk wrote:
>>> Subject    : libata must be initialized earlier
>>> References : http://ozlabs.org/pipermail/linuxppc-dev/2006-November/027945.html
>>> Submitter  : Paul Mackerras <paulus@samba.org>
>>> Handled-By : Brian King <brking@us.ibm.com>
>>> Patch      : http://marc.theaimsgroup.com/?l=linux-ide&m=116169938407596&w=2
>>> Status     : patch available
>> I just resubmitted this patch a few minutes ago.
> 
> I definitely want an ACK on this from Jeff - I'll take a few broken ppc64 
> machines any day over the worry that there might be problems elsewhere. 
> 
> Jeff? Ack, Nack, or "I'll push it to you through my git tree", please..

Reluctant ACK.  But this whole subsys_init() mess is highly fragile, and 
this is going to change again once a new dependency arises :/

	Jeff



