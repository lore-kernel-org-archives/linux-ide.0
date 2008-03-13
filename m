From: "Richard Genoud" <richard.genoud@gmail.com>
Subject: Re: [BUG] PLEXTOR DVDR PX-740A drive not ready for command
Date: Thu, 13 Mar 2008 13:28:24 +0100
Message-ID: <80b317760803130528n2aa80728l86290f3af8d9ab21@mail.gmail.com>
References: <47D8F73F.4090501@gmail.com>
	 <200803131337.17095.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.178]:4992 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbYCMM2Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Mar 2008 08:28:25 -0400
Received: by el-out-1112.google.com with SMTP id v27so2118363ele.17
        for <linux-ide@vger.kernel.org>; Thu, 13 Mar 2008 05:28:24 -0700 (PDT)
In-Reply-To: <200803131337.17095.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@googlemail.com>

> Could we get full dmesg for this particular system/problem?
>
>  Please also;
>  - test 2.6.25-rc5 on _your_ system
>  - verify that configuration of hda and hdb devices is correct
>   (master/slave settings)
>
> There is far too much information there (different error messages,
>  different host drivers, some systems are using libata...) - please
>  open a new bug entry at http://bugzilla.kernel.org so we can start
>  "clean" and fully concentrate on fixing this bug.
>

Ok, I will test that this evening and open a bug entry.

Richard.
