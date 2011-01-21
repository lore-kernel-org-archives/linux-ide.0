From: Tejun Heo <tj@kernel.org>
Subject: Re: MWDMA Issue: sda: unknown partition table
Date: Fri, 21 Jan 2011 11:14:00 +0100
Message-ID: <20110121101400.GC2832@htj.dyndns.org>
References: <4D395B74.1010705@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42874 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753467Ab1AUKOF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Jan 2011 05:14:05 -0500
Received: by fxm20 with SMTP id 20so1584123fxm.19
        for <linux-ide@vger.kernel.org>; Fri, 21 Jan 2011 02:14:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D395B74.1010705@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: viresh kumar <viresh.kumar@st.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Shiraz HASHIM <shiraz.hashim@st.com>, Armando VISCONTI <armando.visconti@st.com>, Amit GOEL <amit.goel@st.com>

On Fri, Jan 21, 2011 at 03:39:56PM +0530, viresh kumar wrote:
> I am implementing mwdma interface for arasan compact flash controller.
> I am facing a strange problem, when i insert CF card on my board (after bootup),
> in mwdma mode, i get following:
> 
> ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen

That's AC_ERR_ATA_BUS.

> Can somebody give any clue on which part i should try to look at?

Yeah, someone is reporting CRC error.

-- 
tejun
