From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH pata-2.6 fix queue] aec62xx: kill speedproc() method wrapper
Date: Tue, 15 May 2007 23:43:12 +0200
Message-ID: <200705152343.12956.bzolnier@gmail.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702162321.40813.sshtylyov@ru.mvista.com> <200705120122.34384.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:35755 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760543AbXEPAqa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 May 2007 20:46:30 -0400
Received: by ug-out-1314.google.com with SMTP id 44so2836uga
        for <linux-ide@vger.kernel.org>; Tue, 15 May 2007 17:46:30 -0700 (PDT)
In-Reply-To: <200705120122.34384.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Friday 11 May 2007, Sergei Shtylyov wrote:
> There's no reason to have the speedproc() method wrapper for the two quite
> different chip families, so just get rid of it.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
