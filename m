From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH V1 1/2] libata-sff: add ata_sff_queue_work() &
 ata_sff_queue_delayed_work()
Date: Fri, 18 Feb 2011 15:11:59 +0100
Message-ID: <20110218141159.GJ21209@htj.dyndns.org>
References: <cover.1298029161.git.viresh.kumar@st.com>
 <1cad52b042eff06bf671c32e48920bf487d800a4.1298029161.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48766 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755011Ab1BROMY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Feb 2011 09:12:24 -0500
Received: by fxm20 with SMTP id 20so3817465fxm.19
        for <linux-ide@vger.kernel.org>; Fri, 18 Feb 2011 06:12:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1cad52b042eff06bf671c32e48920bf487d800a4.1298029161.git.viresh.kumar@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, viresh.linux@gmail.com, shiraz.hashim@st.com, armando.visconti@st.com, amit.goel@st.com

On Fri, Feb 18, 2011 at 05:10:13PM +0530, Viresh Kumar wrote:
> This patch adds ata_sff_queue_work() & ata_sff_queue_delayed_work() routine in
> libata-sff.c file. This routine can be used by ata drivers to use ata_sff_wq.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Acked-by: Tejun Heo <tj@kernel.com>

Thanks.

-- 
tejun
