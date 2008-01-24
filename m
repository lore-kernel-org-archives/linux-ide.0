From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 / Alpha / 4726 PMP issue ..
Date: Fri, 25 Jan 2008 02:08:39 +0900
Message-ID: <4798C617.10601@gmail.com>
References: <4794459C.3090200@gmail.com> <4796DC44.6010100@gmail.com>	 <864c1e490801231622n806b465g88a3f0448b5d8f29@mail.gmail.com>	 <4797ECF3.5000306@gmail.com>	 <864c1e490801231823v3e9cf61ds2a0d553ed5b61fb2@mail.gmail.com>	 <4797F8D0.6060302@gmail.com>	 <864c1e490801231939k6008bc95tf40565a8ef6f430d@mail.gmail.com>	 <47980B71.3000408@gmail.com>	 <864c1e490801240707x31ff53b1s3d72032968e1bcbc@mail.gmail.com>	 <4798AA88.5080107@gmail.com> <864c1e490801240840q5423a1beuf9b4b3a43416db2b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.249]:8780 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755916AbYAXRIx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jan 2008 12:08:53 -0500
Received: by hs-out-2122.google.com with SMTP id 54so283949hsz.5
        for <linux-ide@vger.kernel.org>; Thu, 24 Jan 2008 09:08:52 -0800 (PST)
In-Reply-To: <864c1e490801240840q5423a1beuf9b4b3a43416db2b@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Evans <evans02472@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Thomas Evans wrote:
> That's what I thought - is there another chip that support the 4726
> PMP that you think I could try?

JMicron SATA controllers are ahci and support PMP.

-- 
tejun
