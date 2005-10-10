From: linux@horizon.com
Subject: Re: sata_sil24 AMD64 crash/lockup
Date: 10 Oct 2005 13:40:33 -0400
Message-ID: <20051010174033.5473.qmail@science.horizon.com>
References: <20051006164850.GB8047@htj.dyndns.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([192.35.100.1]:54062 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751050AbVJJRko
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Oct 2005 13:40:44 -0400
In-Reply-To: <20051006164850.GB8047@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, linux@horizon.com
Cc: linux-ide@vger.kernel.org

>  After applying all four patches (above three plus the one I cc'd to
> you), when you hit a SATA error, you'll get proper report.  And we
> should be able to debug that from there.

Just an update - I've been running continuous disk for the last several
days, and no error reports yet.

So sata_sil24 is looking pretty good.  (I'm looking forward to NCQ!)
