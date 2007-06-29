From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH pata-2.6 fix] hpt366: use correct enablebits for HPT36x
Date: Fri, 29 Jun 2007 23:06:59 +0200
Message-ID: <200706292306.59194.bzolnier@gmail.com>
References: <200706300004.22274.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:10005 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753586AbXF2WBK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Jun 2007 18:01:10 -0400
Received: by ug-out-1314.google.com with SMTP id j3so895207ugf
        for <linux-ide@vger.kernel.org>; Fri, 29 Jun 2007 15:01:09 -0700 (PDT)
In-Reply-To: <200706300004.22274.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: michal.kepien@poczta.onet.pl, linas@austin.ibm.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 29 June 2007, Sergei Shtylyov wrote:
> The HPT36x chips finally turned out to have the channel enable bits -- however,
> badly implemented.  Make use of them despite it's probably only going to burden
> the driver's code -- assuming both channels are always enabled by the HighPoint
> BIOS anyway...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
