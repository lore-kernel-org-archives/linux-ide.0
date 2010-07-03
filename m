From: Tejun Heo <tj@kernel.org>
Subject: Re: Rapidly increasing Load_Cycle_Count
Date: Sat, 03 Jul 2010 11:42:35 +0200
Message-ID: <4C2F060B.6030606@kernel.org>
References: <AANLkTinZZi6kzs7XXgYDUHpoTeO6IV0r1Axn3197gWwZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52360 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752903Ab0GCJmj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Jul 2010 05:42:39 -0400
In-Reply-To: <AANLkTinZZi6kzs7XXgYDUHpoTeO6IV0r1Axn3197gWwZ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alberto Passalacqua <albert.passalacqua@gmail.com>
Cc: linux-ide@vger.kernel.org

On 07/02/2010 07:15 PM, Alberto Passalacqua wrote:
> As requested by Tejun here
> https://bugzilla.novell.com/show_bug.cgi?id=545024#c63 , I report a
> problem encountered on a DELL Latitude E6410 with a Seagate hard drive
> (see attachments for details).
> 
> The Load_Cycle_Count increased significantly in the first two days of
> life of the machine reaching the value of 1183, which, according to my
> estimates corresponds to about 60 cycles per hour. The problems was
> fixed by setting a higher value of the power management parameter:
> 
> hdparm -B 254 /dev/sda

Noted in ata-wiki known issues page and added to storage-fixup.

Thanks.

-- 
tejun
