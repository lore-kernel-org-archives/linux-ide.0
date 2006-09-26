From: Tejun Heo <htejun@gmail.com>
Subject: Re: "qc timeout" error in sata_sil 3114 driver, 2.6.18
Date: Tue, 26 Sep 2006 14:18:41 +0900
Message-ID: <4518B831.8060109@gmail.com>
References: <45144D3D.4010400@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:26333 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751101AbWIZFSr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Sep 2006 01:18:47 -0400
Received: by py-out-1112.google.com with SMTP id n25so2832167pyg
        for <linux-ide@vger.kernel.org>; Mon, 25 Sep 2006 22:18:46 -0700 (PDT)
In-Reply-To: <45144D3D.4010400@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Timur Tabi <timur@freescale.com>
Cc: linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

[cc'ing linux-ide]

Timur Tabi wrote:
> I'm working on a new PowerPC board (8349 based) with a Silicon Image 
> 3114 SATA controller
> connected to a Hitachi drive.  When the sata_sil driver loads and tries 
> to find the device,
> I get "qc timeout" errors.  I don't know a lot about SATA.  Can anyone 
> give me a clue as
> to what could be wrong?

Several questions.

1. does any previous kernel version work?  say, 2.6.17?
2. can your ppc board do byte-aligned mmio access?
3. it could be irq routing problem.  can you verify that?

-- 
tejun
