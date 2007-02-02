From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide-floppy: Fix unformatted media crash
Date: Fri, 02 Feb 2007 23:05:20 +0100
Message-ID: <45C3B5A0.7010503@gmail.com>
References: <20070131174123.17aba9d1@localhost.localdomain> <58cb370e0702021351j57c3b559v53741f09acab0b8b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:52069 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946111AbXBBWAa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 17:00:30 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1376824nfa
        for <linux-ide@vger.kernel.org>; Fri, 02 Feb 2007 14:00:29 -0800 (PST)
In-Reply-To: <58cb370e0702021351j57c3b559v53741f09acab0b8b@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org


Alan wrote:
> 
> A ZIP or similar with unformatted media will cause crashes when attempts
> are made to read/write it in some cases. This is because bs_factor is
> zero and we divide by it causing an oops.
> 
> As the size of a non-accessible/non-existant media is really a bit of a
> zen question it doesn't matter if non-existant media is 512 bytes per
> sector or zero. Setting it to 1 causes us to generate 512 bytes/sector
> accesses and error properly.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied, thanks

> Based on a fix found lurking in an ancient bugzilla entry since about
> 2004 (ugghhh)

