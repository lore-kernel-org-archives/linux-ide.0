From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [Bug] 3.16 fwdownload failure on Marvell 88SE9125 sata controller
Date: Tue, 09 Sep 2014 21:38:48 -0600
Message-ID: <540FC7C8.1070904@gmail.com>
References: <CACVXFVN6f3Og+D_70M+4j_qhGNsryJWzTJK8G+rY0sxXweMqQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:45875 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbaIJDiw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Sep 2014 23:38:52 -0400
In-Reply-To: <CACVXFVN6f3Og+D_70M+4j_qhGNsryJWzTJK8G+rY0sxXweMqQg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Gaurav <gspatel@hp.com>

On 01/09/14 02:22 AM, Ming Lei wrote:
> Hi Guys,
>
> When we use hdparm to download firmware on system with
> Marvell 88SE9125 SATA controller, it returns failure always
> and it has been observed in several systems:
>
> #hdparm --fwdownload-mode7 fw.bin
> --yes-i-kno-what-i-am-doing --please-destroy-my-drive /dev/sda
>
> /dev/sda:
> fwdownload: xfer_mode=7 min=1 max=65535 size=699392
> FAILED: Input/output error

Any errors in dmesg after doing this?

