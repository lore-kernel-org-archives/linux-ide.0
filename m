From: Julien Oster <transcode@mc.frodoid.org>
Subject: Re: IDE class driver with SATA controllers
Date: Wed,  1 Sep 2004 17:45:32 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1094053532.4135ee9c29c2f@secure.frodoid.org>
References: <DBFABB80F7FD3143A911F9E6CFD477B03F969B@hqemmail02.nvidia.com> <4135CC6E.3050508@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from enterprise.spok.net ([213.139.94.155]:46497 "EHLO susi.ggom.de")
	by vger.kernel.org with ESMTP id S267195AbUIAPpd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Sep 2004 11:45:33 -0400
In-Reply-To: <4135CC6E.3050508@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Chew <achew@nvidia.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl, Alan Cox <alan@lxorguk.ukuu.org.uk>

Quoting Jeff Garzik <jgarzik@pobox.com>:

Hello Jeff,

> With regards to libata being the default, making that an _option_ is 
> feasible, but we will probably default to the IDE driver for quite some 
> time.  There are issues of /dev/hda versus /dev/sda, keeping existing 
> user setups working, etc.

once there is reasonable support to indeed use libata as default,
we could just wrap a pass through IDE driver around, which allocates the
major numbers for /dev/hd* and just feeds everything to libata. Or are the
semantics too different?

Regards,
Julien


-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/
