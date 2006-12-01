From: Tejun Heo <htejun@gmail.com>
Subject: Re: PMP in sata_sil24
Date: Fri, 01 Dec 2006 10:54:19 +0900
Message-ID: <456F8B4B.6070408@gmail.com>
References: <200611302318.kAUNIS1v030758@tenet.verdasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:64751 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1755139AbWLABya (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Nov 2006 20:54:30 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2299232uga
        for <linux-ide@vger.kernel.org>; Thu, 30 Nov 2006 17:54:29 -0800 (PST)
In-Reply-To: <200611302318.kAUNIS1v030758@tenet.verdasys.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc Bejarano <beej@adverplex.com>
Cc: jeff@garzik.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Raymond Liu <Raymond.Liu@siliconimage.com>

[cc'ing linux-ide and Raymond]

Marc Bejarano wrote:
> trying jeff's other address...
> 
> marc
> =====
> Date: Mon, 13 Nov 2006 14:52:13 -0500
> To: jgarzik@redhat.com
> From: Marc Bejarano <beej@adverplex.com>
> Subject: Fwd: Re: PMP in sata_sil24
> 
> hi, jeff.  have you had any recent contact with tejun?  i've got
> reproducible problems with the sata_sil24 driver and i haven't been able
> to reach him.

Yeap, he had and your message is on my ever-growing to-do list.  Just
haven't had time to work on PMP lately and can't regenerate your problem
here either.  I need to contact SIMG about the issue (hello, Raymond).

I think PMP support waited long enough (IOW, excessively).  Even boards
with on-board PMP are out there.  I'll do something about it soon.

Thanks.

-- 
tejun
