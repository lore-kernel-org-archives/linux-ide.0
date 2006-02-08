From: David Greaves <david@dgreaves.com>
Subject: Re: SMART on SATA reporting errors? (was Re: regarding bug #5914
 - fs corruption on SATA)
Date: Wed, 08 Feb 2006 07:21:21 +0000
Message-ID: <43E99BF1.6050207@dgreaves.com>
References: <20060126055050.GA4737@htj.dyndns.org> <43D8FBBD.6070205@dgreaves.com> <43D8FF9A.4020805@pobox.com> <43D903AC.5000309@dgreaves.com> <43E8E85F.5000905@dgreaves.com> <43E8F558.4040002@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from s2.ukfsn.org ([217.158.120.143]:20664 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1161066AbWBHHVV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Feb 2006 02:21:21 -0500
In-Reply-To: <43E8F558.4040002@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux-ide <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Nicolas.Mailhot@LaPoste.net, Jens Axboe <axboe@suse.de>, Christopher Smith <csmith@nighthawkrad.net>, Erik Slagter <erik@slagter.name>, hahn@physics.mcmaster.ca, mlaks@verizon.net, Soeren Sonnenburg <kernel@nn7.de>, mlaks@verizononline.net, smartmontools-support@lists.sourceforge.net

Jeff Garzik wrote:

> David Greaves wrote:
>
>> I did a little investigation and I see that when I do:
>> # smartctl -o on -data /dev/sdb
>
<snip>

> All of your commands are missing "-d ata"

well, technically yes, I used -data in all of them, is the space or option order important?


David Greaves wrote:
# smartctl -o on -data /dev/sdb
# smartctl -o off -data /dev/sda
# smartctl -s on -data /dev/sda
# smartctl -s off -data /dev/sda
# smartctl -S off -data /dev/sdc

David


-- 

