From: Tejun Heo <tj@kernel.org>
Subject: Re: PMP and Smart Enclosure ...
Date: Mon, 28 Mar 2011 10:52:11 +0200
Message-ID: <20110328085211.GD16530@htj.dyndns.org>
References: <20110322145440.GA15541@MAIL.13thfloor.at>
 <20110322152529.GB15541@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45180 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab1C1IwQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Mar 2011 04:52:16 -0400
Received: by bwz15 with SMTP id 15so2242673bwz.19
        for <linux-ide@vger.kernel.org>; Mon, 28 Mar 2011 01:52:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110322152529.GB15541@MAIL.13thfloor.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: linux-ide@vger.kernel.org

On Tue, Mar 22, 2011 at 04:25:29PM +0100, Herbert Poetzl wrote:
> >  echo "- - -" >/sys/class/scsi_host/host9/scan
> 
> >  scsiadd -s 9
> 
> >  resetting the PMP (via small front panel button)

Can you please attach kernel log while this is happening?

Thanks.

-- 
tejun
