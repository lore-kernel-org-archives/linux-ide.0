From: Bernd Schubert <bs@q-leap.de>
Subject: Re: sata sil3114 vs. certain seagate drives results in filesystem corruptions
Date: Mon, 22 Oct 2007 13:02:11 +0200
Message-ID: <200710221302.12229.bs@q-leap.de>
References: <1192863324.5720.162.camel@localhost> <200710221148.08809.bs@q-leap.de> <1193049392.10246.29.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns1.q-leap.de ([153.94.51.193]:34650 "EHLO mail.q-leap.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752026AbXJVLCP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Oct 2007 07:02:15 -0400
In-Reply-To: <1193049392.10246.29.camel@localhost>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

On Monday 22 October 2007 12:36:32 Soeren Sonnenburg wrote:
> > but as much as it fits onto the disk. On reading back this file, the
> > filesystem will report errors somewhere between 50GB and 230GB (disk size
> > is 250GB).
>
> Wow, I really see lots of corruptions (well every 1-2 GB a couple of
> bytes are corrupted). Are you getting similiarly many in the 50G - 230G
> region?

I never tested what is corrupted. Well, a diff over 250GB would take quite a 
lot of time...

-- 
Bernd Schubert
Q-Leap Networks GmbH
