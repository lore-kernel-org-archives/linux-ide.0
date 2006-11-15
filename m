From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata_piix on Thinkpad T30 - qc timeout on boot
Date: Wed, 15 Nov 2006 20:12:20 +0900
Message-ID: <455AF614.1090109@gmail.com>
References: <1163563453.3100.24.camel@dv> <1163569390.4410.8.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:54582 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030257AbWKOLM2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Nov 2006 06:12:28 -0500
Received: by ug-out-1314.google.com with SMTP id m3so101123ugc
        for <linux-ide@vger.kernel.org>; Wed, 15 Nov 2006 03:12:26 -0800 (PST)
In-Reply-To: <1163569390.4410.8.camel@dv>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-ide@vger.kernel.org

Pavel Roskin wrote:
> So the problem has been reduced to Matsushita (Matshita Panasonic)
> UJDA720 in an IBM Thinkpad blocking detection of empty slave on the same
> port.  It's clearly a regression in libata compared to the IDE driver,
> and it would be nice to have it fixed.

Fixed in libata-dev#upstream and will soon be included in -mm.  Please 
read the following thread.

http://thread.gmane.org/gmane.linux.ide/13975/focus=13975

-- 
tejun
