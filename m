From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Replace C code with call to ARRAY_SIZE() macro.
Date: Fri, 8 Jun 2007 14:06:44 +0200
Message-ID: <200706081406.44841.bzolnier@gmail.com>
References: <Pine.LNX.4.64.0706031339110.24621@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:48188 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967814AbXFHNJH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jun 2007 09:09:07 -0400
Received: by ug-out-1314.google.com with SMTP id j3so950343ugf
        for <linux-ide@vger.kernel.org>; Fri, 08 Jun 2007 06:09:06 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0706031339110.24621@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: linux-ide@vger.kernel.org

On Sunday 03 June 2007, Robert P. J. Day wrote:
> 
> Delete the unnecessary macro ARY_LEN and use ARRAY_SIZE directly.
> 
> Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

applied
