From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/2] sata_inic162x: finally, driver for initio 162x SATA
 controllers
Date: Mon, 18 Dec 2006 09:04:44 +0900
Message-ID: <4585DB1C.3020907@gmail.com>
References: <20061217014827.GK5400@htj.dyndns.org>	<20061217015008.GL5400@htj.dyndns.org> <20061217122431.5dd6339e@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:10846 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243AbWLRAEz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Dec 2006 19:04:55 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1778744nfa
        for <linux-ide@vger.kernel.org>; Sun, 17 Dec 2006 16:04:54 -0800 (PST)
In-Reply-To: <20061217122431.5dd6339e@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, bob@evoria.net, nabble@theanthonys.net, matthias@urlichs.de, romieu@fr.zoreil.com, carlosmarcelomartinez@gmail.com

Alan wrote:
> On Sun, 17 Dec 2006 10:50:08 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> Driver for Initio 162x SATA controllers.  ATA r/w, ATAPI r, hotplug
>> and suspend/resume work.  ATAPI w (recording, that is) broken. 
> 
> Does atapi write work if you just clip it to PIO for writing ?

No, PIO ATAPI doesn't work at all (so, the ATA_FLAG_PIO_DMA flag).  I
tried a lot of combinations but it always gives weird ireason and
overriding ireason results in all sorts of errors.  Dunno why.

-- 
tejun
