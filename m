From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata-core: Allow longer timeout for drive spinup from
 PUIS
Date: Mon, 4 Apr 2016 12:18:09 -0400
Message-ID: <20160404161809.GY7822@mtj.duckdns.org>
References: <539D1F09-E6EB-47F1-A66E-C182CA675359@hgst.com>
 <20160330183846.GK7822@mtj.duckdns.org>
 <D088F533-0243-4414-9B03-BC177DC1D35C@hgst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:33111 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbcDDQSL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Apr 2016 12:18:11 -0400
Received: by mail-yw0-f177.google.com with SMTP id t10so70442316ywa.0
        for <linux-ide@vger.kernel.org>; Mon, 04 Apr 2016 09:18:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <D088F533-0243-4414-9B03-BC177DC1D35C@hgst.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Damien Le Moal <Damien.LeMoal@hgst.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Sat, Apr 02, 2016 at 12:23:02PM +0000, Damien Le Moal wrote:
> Sorry about the email format (I am sending emails in plain text, but my
> Outlook exchange client/exchange server does not seem to be respecting
> that format).
> 
> Here is the patch as attachment, reworked to define the timeout in
> milliseconds as you suggested.

Applied to libata/for-4.7.  Can you please use git format-patch to
generate the patch file from next time?

Thanks.

-- 
tejun
