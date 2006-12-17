From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] sata_inic162x: finally, driver for initio 162x SATA
 controllers
Date: Sun, 17 Dec 2006 12:24:31 +0000
Message-ID: <20061217122431.5dd6339e@localhost.localdomain>
References: <20061217014827.GK5400@htj.dyndns.org>
	<20061217015008.GL5400@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53722 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752510AbWLQMQ3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Dec 2006 07:16:29 -0500
In-Reply-To: <20061217015008.GL5400@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, bob@evoria.net, nabble@theanthonys.net, matthias@urlichs.de, romieu@fr.zoreil.com, carlosmarcelomartinez@gmail.com

On Sun, 17 Dec 2006 10:50:08 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Driver for Initio 162x SATA controllers.  ATA r/w, ATAPI r, hotplug
> and suspend/resume work.  ATAPI w (recording, that is) broken. 

Does atapi write work if you just clip it to PIO for writing ?
