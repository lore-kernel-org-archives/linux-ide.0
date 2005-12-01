From: "0602@eq.cz" <0602@eq.cz>
Subject: Re: totally random "VFS: Cannot open root device"
Date: Thu, 01 Dec 2005 16:34:21 +0100
Message-ID: <438F17FD.9020108@eq.cz>
References: <438B6E05.8070009@eq.cz> <438D2C19.3030008@gmail.com> <438DA3FA.2010809@eq.cz> <a762e240511301405s433109b7n93e7fdcc7409bef5@mail.gmail.com> <438EC502.1090103@keytradebank.com> <20051201112015.GA10462@htj.dyndns.org> <438EF3B6.7020007@keytradebank.com> <438EFAA5.3070901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.cesky-hosting.cz ([81.0.238.178]:26601 "EHLO
	mail.cesky-hosting.cz") by vger.kernel.org with ESMTP
	id S932271AbVLAPdk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Dec 2005 10:33:40 -0500
In-Reply-To: <438EFAA5.3070901@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: =?ISO-8859-1?Q?Jean-Fran=E7ois_Stenuit?= <jfs@keytradebank.com>, Keith Mannthey <kmannth@gmail.com>, Linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Hi,

Tejun Heo wrote:
[...]
> It probably is a BIOS issue.  The weird thing though is that the port 
> works fine with its corresponding ENABLED bit cleared.  Anyways, if it 
> works by ignoring the ENABLED bit, ignoring should just be fine.
> 
> 0602, can you verify this workaround works on your machine too?
[..]

Yes, I made about 20 subsequent reboots with ata_piix.override_PCS=1 and 
the system always booted without a hiccup.

Regards,

r.
