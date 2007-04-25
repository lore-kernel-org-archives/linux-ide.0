From: "Berck E. Nash" <flyboy@gmail.com>
Subject: Re: 2.6.21-rc7-mm1 BUG at kernel/sched-clock.c:175 init_sched_clock()
Date: Wed, 25 Apr 2007 06:28:56 -0600
Message-ID: <462F4988.8000109@gmail.com>
References: <462E4C4D.9020806@gmail.com> <20070425011654.222a2b4b.akpm@linux-foundation.org> <462F1481.8010807@gmail.com> <20070425085432.GD17130@htj.dyndns.org> <20070425093044.GE17130@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.237]:64206 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965440AbXDYM3C (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Apr 2007 08:29:02 -0400
Received: by wx-out-0506.google.com with SMTP id h31so216179wxd
        for <linux-ide@vger.kernel.org>; Wed, 25 Apr 2007 05:29:01 -0700 (PDT)
In-Reply-To: <20070425093044.GE17130@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Please test this one instead.  Thanks.

Yup, the second patch fixes it.

-Berck
