From: "Dong Feng" <middle.fengdong@gmail.com>
Subject: Re: 2.6.22.5 SATA Failure
Date: Sun, 26 Aug 2007 18:04:06 +0800
Message-ID: <a2ebde260708260304y40394ea9jb6065a51f789ca3f@mail.gmail.com>
References: <fa.9lnv231u8AU5Nlw9OFEhJs+u+Yw@ifi.uio.no>
	 <46D1013D.5040801@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:46811 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbXHZKEH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Aug 2007 06:04:07 -0400
Received: by wa-out-1112.google.com with SMTP id j4so1656820wah
        for <linux-ide@vger.kernel.org>; Sun, 26 Aug 2007 03:04:06 -0700 (PDT)
In-Reply-To: <46D1013D.5040801@shaw.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

2007/8/26, Robert Hancock <hancockr@shaw.ca>:
>
> It looks like you have some CONFIG_IDE options enabled in your kernel
> configuration that result in drivers/ide trying to drive part or all of
> that controller, preventing libata from doing so. Likely the easiest
> thing to do is just set CONFIG_IDE=n entirely..
>
> --
> Robert Hancock      Saskatoon, SK, Canada
> To email, remove "nospam" from hancockr@nospamshaw.ca
> Home Page: http://www.roberthancock.com/
>
>

The SATA works with 2.6.22.5 after CONFIG_IDE =n being set.

Thank you very much.
