From: Tejun Heo <htejun@gmail.com>
Subject: Re: HSM violation spew.
Date: Fri, 07 Sep 2007 13:42:07 +0900
Message-ID: <46E0D69F.9060107@gmail.com>
References: <20070829184925.GF31948@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:42590 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbXIGEmP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Sep 2007 00:42:15 -0400
Received: by rv-out-0910.google.com with SMTP id k20so330411rvb
        for <linux-ide@vger.kernel.org>; Thu, 06 Sep 2007 21:42:15 -0700 (PDT)
In-Reply-To: <20070829184925.GF31948@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: linux-ide@vger.kernel.org

Dave Jones wrote:
> scsi 2:0:0:0: Direct-Access     ATA      WDC WD3200AAJS-0 12.0 PQ: 0 ANSI: 5

This could have been truncated, please post the result of 'hdparm -I
/dev/sda'.  Thanks.

-- 
tejun
