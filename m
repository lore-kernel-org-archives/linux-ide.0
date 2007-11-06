From: "Michal Suchanek" <hramrach@centrum.cz>
Subject: Re: Maxtor 6L200M0 sata irq timeouts
Date: Tue, 6 Nov 2007 18:29:49 +0100
Message-ID: <a5d587fb0711060929s2ae7d406s6f6c2c2909406a93@mail.gmail.com>
References: <a5d587fb0709090234x1942e987u4187bf0dbe977a06@mail.gmail.com>
	 <6b9952490709090740t188d5b71x26b90421bfe948bf@mail.gmail.com>
	 <a5d587fb0709090920y1241a528x4f5a1141026256a7@mail.gmail.com>
	 <46E473D2.20907@gmail.com>
	 <a5d587fb0709100711s16a6df24i8fac5693c5cc8952@mail.gmail.com>
	 <46E5F15A.2090803@gmail.com>
	 <a5d587fb0709110429j6ce52fb2wb1d558281b36f8a7@mail.gmail.com>
	 <46FB56EF.8050703@gmail.com>
	 <a5d587fb0710011321w6ac7506cm81e917fcfa1fb7ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:3097 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbXKFR3v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Nov 2007 12:29:51 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1143859ugc
        for <linux-ide@vger.kernel.org>; Tue, 06 Nov 2007 09:29:49 -0800 (PST)
In-Reply-To: <a5d587fb0710011321w6ac7506cm81e917fcfa1fb7ca@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Joris <joris@v5.be>, linux-ide@vger.kernel.org

On 01/10/2007, Michal Suchanek <hramrach@centrum.cz> wrote:
> Hello
>
> (please CC me when replying)
>
>

I got a replacement drive which is also a 6L200M0 but the fw rev is
now BACE1G10.

Both the irq errors and the smart checksum errors are gone. I guess
these were cause by old and buggy drive firmware in my case.

Thanks

Michal
