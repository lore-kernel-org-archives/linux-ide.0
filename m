From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.22 3/3] Add LED trigger to libata core
Date: Tue, 20 Mar 2007 12:38:49 +0900
Message-ID: <45FF5749.6010407@gmail.com>
References: <20070319214907.094B65B80F2@ganymede.vroon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.238]:52664 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933166AbXCTDi6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Mar 2007 23:38:58 -0400
Received: by nz-out-0506.google.com with SMTP id s1so758527nze
        for <linux-ide@vger.kernel.org>; Mon, 19 Mar 2007 20:38:57 -0700 (PDT)
In-Reply-To: <20070319214907.094B65B80F2@ganymede.vroon.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tony Vroon <chainsaw@gentoo.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Tony Vroon wrote:
> The first user of ata_ac_issue_prot_with_ledtrigger, the ServerWorks Frodo/
> Apple K2 driver. Used by the IDE LED trigger on G5 towers.
> Respin of an earlier patch, based on comments by Tejun Heo & Alan Cox.

Just two comments.

1. IMHO, ata_qc_issue_prot_ledtrigger() without 'with' is good enough. 
This is just my personal preference.  Feel free to ignore it.

2. Patch #1 and #2 should be merged.  They're one logical change of 
adding ata_qc_issue_prot_with_ledtrigger().  Patch #3 is a logically 
separate change of using it, but unless it's a wide conversion, 
implementing something and using something can be merged.  So, please 
merge #1 and #2 and possibly #3.

Thanks.

-- 
tejun
