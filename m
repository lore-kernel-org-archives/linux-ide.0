From: Tejun Heo <htejun@gmail.com>
Subject: Re: Change Libata Error Handling for Drive Testing
Date: Tue, 20 Mar 2007 12:52:27 +0900
Message-ID: <45FF5A7B.2010101@gmail.com>
References: <8202f4270703182216r33860cbdha404865d05a03b81@mail.gmail.com>	 <45FE3F17.4010500@gmail.com>	 <8202f4270703190927p4fd7098at5d0f4706d66009cf@mail.gmail.com>	 <8202f4270703191001l50250d2fndb7403e41c39fa1@mail.gmail.com> <8202f4270703191007i1874a6c9y781bd52885390ab6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:14850 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933282AbXCTDwg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Mar 2007 23:52:36 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1493866uga
        for <linux-ide@vger.kernel.org>; Mon, 19 Mar 2007 20:52:35 -0700 (PDT)
In-Reply-To: <8202f4270703191007i1874a6c9y781bd52885390ab6@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Fajun Chen wrote:
> Please ignore the changes to pata_sil680.c. The same failure happened
> to standard sil680 driver without my change as well.

Does it also happen when the second port is empty?

-- 
tejun
