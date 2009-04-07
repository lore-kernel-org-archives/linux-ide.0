From: Grant Grundler <grundler@google.com>
Subject: Re: [Bugme-new] [Bug 13001] New: PCI-DMA: Out of IOMMU space
Date: Tue, 7 Apr 2009 14:14:19 -0700
Message-ID: <da824cf30904071414j7b8a06cavceb051ac023674d2@mail.gmail.com>
References: <bug-13001-10286@http.bugzilla.kernel.org/>
	 <20090404114559.ce20eb9c.akpm@linux-foundation.org>
	 <db2b43030904050239t6abf1c35q216c24a215276269@mail.gmail.com>
	 <da824cf30904070914m2e9deaf8o4236fa2173480fe9@mail.gmail.com>
	 <db2b43030904070946x495cf76et2fd4571f0ac96634@mail.gmail.com>
	 <db2b43030904070952k5fe88addsa1b664fc1d4e89a9@mail.gmail.com>
	 <db2b43030904071323x296e5689q74376339d6aaec7@mail.gmail.com>
	 <da824cf30904071359i35cd0722p85b9943c9bb5a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:12862 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761294AbZDGVOZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Apr 2009 17:14:25 -0400
Received: from wpaz1.hot.corp.google.com (wpaz1.hot.corp.google.com [172.24.198.65])
	by smtp-out.google.com with ESMTP id n37LELd3028228
	for <linux-ide@vger.kernel.org>; Tue, 7 Apr 2009 22:14:21 +0100
Received: from qyk28 (qyk28.prod.google.com [10.241.83.156])
	by wpaz1.hot.corp.google.com with ESMTP id n37LE0Vk006882
	for <linux-ide@vger.kernel.org>; Tue, 7 Apr 2009 14:14:19 -0700
Received: by qyk28 with SMTP id 28so5407012qyk.28
        for <linux-ide@vger.kernel.org>; Tue, 07 Apr 2009 14:14:19 -0700 (PDT)
In-Reply-To: <da824cf30904071359i35cd0722p85b9943c9bb5a3@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?0JTQsNC90LjQu9CwINCW0YPQutC+0YbQutC40Lk=?= <optimusgd@gmail.com>
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, bugme-daemon@bugzilla.kernel.org, x86@kernel.org

Forgot one other possibility...

2009/4/7 Grant Grundler <grundler@google.com>:
....
> My first impression: the bug is either allocdma exists instead of using
> DMA API (See Documentation/DMA-API.txt) OR the documentation for
> allocdma is missing warnings about "this could break your system"
> and clearly specify when it should be used.

or it's a bug in allowdac implementation.

BTW, this whole thread probably needs to be re-posted to either
linux-pci or linux kernel. I don't think linux-ide is the right place
to resolve this.

grant
