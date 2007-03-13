From: Vitaliyi <imgrey@gmail.com>
Subject: Re: Fwd: libata extension
Date: Tue, 13 Mar 2007 04:36:52 +0200
Message-ID: <3aac340703121936k51df425dg7e1a74688a67075@mail.gmail.com>
References: <3aac340703102322p362998b9labedc13503702d2b@mail.gmail.com>
	 <3aac340703121003l43685599t8dbffe6247879a91@mail.gmail.com>
	 <3aac340703121007q35c7acf7t648e0ed7608be04d@mail.gmail.com>
	 <200703122106.39669.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:36799 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052AbXCMCgy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Mar 2007 22:36:54 -0400
Received: by ug-out-1314.google.com with SMTP id 44so97115uga
        for <linux-ide@vger.kernel.org>; Mon, 12 Mar 2007 19:36:53 -0700 (PDT)
In-Reply-To: <200703122106.39669.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> Why is the access to Control register needed?

To execute soft reset for example.

> > In the perfect case i would like to be able to execute vendor command
> > set (reverse engineered).
>
> Sounds interesting. :-)
>
> Could you give some more details on what are you going to implement?

Reading/writing service area, uploading, downloading modules, working
with flash etc.
