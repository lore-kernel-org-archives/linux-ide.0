From: Jim Duda <jim@duda.tzo.com>
Subject: Re: 2.6.31-rc1 with ide-tape / STT2000A
Date: Sat, 08 Aug 2009 17:44:13 -0400
Message-ID: <h5krje$ec7$1@ger.gmane.org>
References: <h5kn9c$51r$1@ger.gmane.org> <4A7DE735.6090409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:55974 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374AbZHHVo1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Aug 2009 17:44:27 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MZtiC-0002lj-Ex
	for linux-ide@vger.kernel.org; Sat, 08 Aug 2009 21:44:24 +0000
Received: from pool-96-252-13-163.bstnma.fios.verizon.net ([96.252.13.163])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 08 Aug 2009 21:44:24 +0000
Received: from jim by pool-96-252-13-163.bstnma.fios.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 08 Aug 2009 21:44:24 +0000
In-Reply-To: <4A7DE735.6090409@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

thi
> My first suggestion would be to try using the libata drivers instead of
> the old IDE ones. The st driver should be able to access the tape then.
> I'm not sure if many people are running ATAPI tape drives on libata
> these days, but the old IDE drivers certainly don't get a lot of use.
> --

Where/how can I learn how to access my tape drive using libata?

Is there something specific I need to enable in the kernel?

> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
>


