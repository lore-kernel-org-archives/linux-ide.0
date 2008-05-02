From: Alan Cox <alan@redhat.com>
Subject: Re: [patch 2/3] pata_atiixp: simplex clear
Date: Fri, 2 May 2008 17:40:19 -0400
Message-ID: <20080502214019.GA5582@devserv.devel.redhat.com>
References: <200805022037.m42Kbfoj013533@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:60023 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758965AbYEBVlE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 May 2008 17:41:04 -0400
Content-Disposition: inline
In-Reply-To: <200805022037.m42Kbfoj013533@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

On Fri, May 02, 2008 at 01:37:41PM -0700, akpm@linux-foundation.org wrote:
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> 
> Some of the other quirks changes seem to have left some users with the simplex
> bits mis-set by the time the driver loads.  Clear simplex mode before we probe
> the controller therefore.

Self NAK this one. I turns out to be *far* more complicated and I sent
Jeff a replacement fix

