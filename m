From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCHSET 05/11] add NCQ support, take 3
Date: Sat, 13 May 2006 18:39:46 -0400
Message-ID: <44666032.8040006@pobox.com>
References: <1147358682210-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:13193 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964785AbWEMWjy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 May 2006 18:39:54 -0400
In-Reply-To: <1147358682210-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> An-Nyoung.
> 
> This is part of patchset series described in [T].
> 
> This is the third take of add-NCQ-support patchset.  Changes from the
> last take [L] are
[...]
> This patchset is against
> 
>   upstream (acc696d93dcf993dec123d69d599979e1456ffec)
>   + [1] prep-for-new-EH patchset
>   + [2] new-EH-framework patchset, take 3
>   + [3] new-EH-implementation patchset, take 3
>   + [4] merge-irq-pio patchset
> 
> --
> tejun
> 
> [T] http://article.gmane.org/gmane.linux.ide/9957
> [L] http://article.gmane.org/gmane.linux.ide/9555
> [1] http://article.gmane.org/gmane.linux.ide/9959
> [2] http://article.gmane.org/gmane.linux.ide/9984
> [3] http://article.gmane.org/gmane.linux.ide/9995
> [4] http://article.gmane.org/gmane.linux.ide/10005

ACK entire patchset.  Yay, NCQ!  Thanks to you and Jens for your hard work.

	Jeff


