From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] libata: reimplement suspend/resume support and fix
 spindown on poweroff
Date: Sun, 06 May 2007 22:24:54 +0200
Message-ID: <463E3996.2070200@gmail.com>
References: <463B88EC.1080304@gmail.com> <b637ec0b0705061311v1f9997k1c1d9b959b87082d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:40973 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbXEFU0J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 May 2007 16:26:09 -0400
Received: by py-out-1112.google.com with SMTP id a29so1039927pyi
        for <linux-ide@vger.kernel.org>; Sun, 06 May 2007 13:26:08 -0700 (PDT)
In-Reply-To: <b637ec0b0705061311v1f9997k1c1d9b959b87082d@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fabio Comolli <fabio.comolli@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Mark Lord <lkml@rtr.ca>, hancockr@shaw.ca, cebbert@redhat.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, emisca.ml@gmail.com, IDE/ATA development list <linux-ide@vger.kernel.org>, Stephen.Clark@seclark.us, a.p.zijlstra@chello.nl

Fabio Comolli wrote:
> Doesn't apply to today Linus' git tree:
> 
> [fcomolli@tycho linux-2.6]$ git pull  git://htj.dyndns.org/libata-tj
> spindown
> remote: Generating pack...
> remote: Done counting 14283 objects.
> remote: Result has 11254 objects.
> remote: Deltifying 11254 objects.
> remote:  100% (11254/11254) done
> Indexing 11254 objects.
> remote: Total 11254 (delta 9842), reused 11241 (delta 9832)
> 100% (11254/11254) done
> Resolving 9842 deltas.
> 100% (9842/9842) done
> 1948 objects were added to complete this thin pack.
> 100% (44114/44114) done
> Auto-merged Documentation/feature-removal-schedule.txt
> CONFLICT (content): Merge conflict in
> Documentation/feature-removal-schedule.txt
> Automatic merge failed; fix conflicts and then commit the result.
> 
> I don't know git enough to identify the conflict. Can anyone help me?

That's a conflict in feature-removal-schedule.txt document.  Open the
file, look for <<<< or >>>> and fix them up, do "git-update-index
Documentation/feature-removal-schedule.txt" followed by "git commit" and
you should be done.  Alternatively, you can just test the spindown
branch as-is by doing 'git-fetch git://htj.dyndns.org/libata-tj
spindown:spindown', then 'git checkout spindown'.

-- 
tejun
