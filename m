From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: don't set PIO mode on pre-EIDE drives
Date: Fri, 16 Nov 2007 22:35:00 +0100
Message-ID: <200711162235.01025.bzolnier@gmail.com>
References: <200711161626.25580.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:7282 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757393AbXKPVb3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Nov 2007 16:31:29 -0500
Received: by ug-out-1314.google.com with SMTP id z38so707011ugc
        for <linux-ide@vger.kernel.org>; Fri, 16 Nov 2007 13:31:28 -0800 (PST)
In-Reply-To: <200711161626.25580.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Friday 16 November 2007, Sergei Shtylyov wrote:
> Fix handling of  the PIO modes for the pre-EIDE drives that did not support
> the PIO Flow Control Transfer Mode value (00001 nnn) of the Set Transfer Mode
> feature by  skipping the actual mode programming.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
