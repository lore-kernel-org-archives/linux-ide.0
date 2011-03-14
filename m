From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH V1 resend 1/2] libata-sff: add ata_sff_queue_work() &
 ata_sff_queue_delayed_work()
Date: Mon, 14 Mar 2011 02:54:39 -0400
Message-ID: <4D7DBBAF.1080901@pobox.com>
References: <cover.1298358936.git.viresh.kumar@st.com> <f9a8bb8c5bcba1b9e5f84f8cfcfbc4a0f338151f.1298358936.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:34363 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753755Ab1CNGyn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Mar 2011 02:54:43 -0400
Received: by vxi39 with SMTP id 39so4068856vxi.19
        for <linux-ide@vger.kernel.org>; Sun, 13 Mar 2011 23:54:42 -0700 (PDT)
In-Reply-To: <f9a8bb8c5bcba1b9e5f84f8cfcfbc4a0f338151f.1298358936.git.viresh.kumar@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, shiraz.hashim@st.com, amit.goel@st.com, armando.visconti@st.com, viresh.linux@gmail.com

On 02/22/2011 04:02 AM, Viresh Kumar wrote:
> This patch adds ata_sff_queue_work()&  ata_sff_queue_delayed_work() routine in
> libata-sff.c file. This routine can be used by ata drivers to use ata_sff_wq.
>
> Signed-off-by: Viresh Kumar<viresh.kumar@st.com>
> Acked-by: Tejun Heo<tj@kernel.org>

applied 1-2


