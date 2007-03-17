From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Sat, 17 Mar 2007 21:07:42 +0100
Message-ID: <200703172107.42107.bzolnier@gmail.com>
References: <45F873AC.6010204@gmail.com> <200703172012.39295.bzolnier@gmail.com> <45FC400D.8090700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:56782 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852AbXCQUAZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Mar 2007 16:00:25 -0400
Received: by ug-out-1314.google.com with SMTP id 44so980019uga
        for <linux-ide@vger.kernel.org>; Sat, 17 Mar 2007 13:00:23 -0700 (PDT)
In-Reply-To: <45FC400D.8090700@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: YUP <yupadmin@gmail.com>
Cc: albertl@mail.com, linux-ide@vger.kernel.org


On Saturday 17 March 2007, YUP wrote:
> Just to check up can you recheck my config?

Looks fine but please set CONFIG_ATA_PIIX to "n" (just in case).

Bart
