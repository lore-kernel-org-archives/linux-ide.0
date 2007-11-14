From: "Morrison, Tom" <tmorrison@empirix.com>
Subject: 2.6.23.1 - sata_mv (7042) hang with large file operations
Date: Wed, 14 Nov 2007 12:49:28 -0500
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D9010AAE852F@EMPBEDEX.empirix.com>
References: <BD261180E6D35F4D9D32F3E44FD3D901053E84BD@EMPBEDEX.empirix.com> <45ED682A.9040408@garzik.org> <BD261180E6D35F4D9D32F3E44FD3D9010A7E1B45@EMPBEDEX.empirix.com> <4728A816.8020608@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [12.38.203.54] ([12.38.203.54]:59573 "EHLO
	empbedex1.empirix.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754987AbXKNRtd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Nov 2007 12:49:33 -0500
Content-class: urn:content-classes:message
In-Reply-To: <4728A816.8020608@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

All,

I apologize if this has been discussed - but I haven't been
able to find exactly what I am looking for in the discussions 
the last few weeks...

I am running Linux 2.6.23.1 and have a 7042 SATA driver running
(that seems to run very well) - it has the fixes talked about
between Jeff & Olaf (mv_sg_fill changes)....

The problem comes ONLY when I am doing large file operations 
(e.g.: just copying a file) to/from the SATA drives behind 
the subject line 7042....it just hangs after about 10-15 
seconds into the copy...

How large a file causes the hang - you ask - well, somewhere 
between 100Meg & 500Meg...

In all other respects - this driver seems to be working...

Is there a known problem - or do I need to describe in more
detail?

Thanks in advance for any / all ideas / questions /...etc


Tom Morrison
Principal S/W Engineer
Empirix, Inc (www.empirix.com)
tmorrison@empirix.com
(781) 266 - 3567


