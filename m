From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/4] libata: Improve timeout handling
Date: Wed, 22 Oct 2008 17:04:58 +0100
Message-ID: <20081022170458.71f2171b@lxorguk.ukuu.org.uk>
References: <20081017180655.7781.15021.stgit@localhost.localdomain>
	<20081017180848.7781.59492.stgit@localhost.localdomain>
	<87ej28skc3.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:56763 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755074AbYJVQE4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Oct 2008 12:04:56 -0400
In-Reply-To: <87ej28skc3.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

> Also, perhaps we cannot agree on the style of multiple line comments,
> but please check this patch for whitespace issues, there is even one
> that can easily be spotted without running checkpatch.pl.

I did, and the follow up patch nicely cleaned up everything checkpatch
complained about for the whole file.

The approach of twiddling random slices of file into coding style buried
in other patches is IMHO just silly. Its as quick to do the lot, so I
did ;)

Alan
--
bork bork!
