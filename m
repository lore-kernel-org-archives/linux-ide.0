From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Add some missing command descriptions
Date: Sun, 27 Oct 2013 08:41:17 -0400
Message-ID: <20131027124117.GM14934@mtj.dyndns.org>
References: <5265D446.8020002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:48003 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161Ab3J0Mlm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Oct 2013 08:41:42 -0400
Received: by mail-qa0-f45.google.com with SMTP id ii20so1535659qab.18
        for <linux-ide@vger.kernel.org>; Sun, 27 Oct 2013 05:41:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5265D446.8020002@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: ide <linux-ide@vger.kernel.org>

On Mon, Oct 21, 2013 at 07:26:30PM -0600, Robert Hancock wrote:
> Add some missing command enumerations from the ATA-8 ACS-3 spec into 
> include/linux/ata.h, and add the corresponding human-readable command
> descriptions in libata-eh.c.
> 
> Signed-off-by: Robert Hancock <hancockrwd@gmail.com>

Applied to libata/for-3.13.  Thanks.

-- 
tejun
