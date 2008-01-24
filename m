From: "Jim MacBaine" <jmacbaine@gmail.com>
Subject: Re: SATA timeouts on two disks
Date: Thu, 24 Jan 2008 18:31:56 +0100
Message-ID: <3afbacad0801240931w4587d79cj6a84f36320573a9a@mail.gmail.com>
References: <3afbacad0801121656u7318de7l57ba5064da259f3f@mail.gmail.com>
	 <18313.65287.290482.369023@harpo.it.uu.se>
	 <3afbacad0801190822v19be782er3d48cbc94293e262@mail.gmail.com>
	 <47944E2E.2070300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:2893 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364AbYAXRb7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jan 2008 12:31:59 -0500
Received: by py-out-1112.google.com with SMTP id u52so488041pyb.10
        for <linux-ide@vger.kernel.org>; Thu, 24 Jan 2008 09:31:59 -0800 (PST)
In-Reply-To: <47944E2E.2070300@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Hi,

On Jan 21, 2008 8:47 AM, Tejun Heo <htejun@gmail.com> wrote:

> If you still have the old PSU lying around, please try to power one of
> the failing drive with the old PSU.  Just leave everything else as-is,
> power-up old PSU by itself as described in the following web page and
> connect only one of the failing drive to the old PSU.
>
>   http://modtown.co.uk/mt/article2.php?id=psumod
>
> And see whether the problem continues and if so on which drives.
> Connecting SATA drives to separate power is completely safe even if they
> don't have common ground because SATA connection never directly connect
> to each other.

Yes, I still have the old PSU lying around.

A co-worker, to whom I explained my problem, asked me whether I had
properly grounded my drives. In fact I had not: The drives resided in
a vibration-absorbing frame through which their exterior had no
electrical contact with the grounded case. Since I grounded the drives
two days ago, I got no new errors.  So maybe my problem is solved.

If not, I will happily try out your suggestion. Would you be so kind
to explain in a few words, what connecting one drive to a second
(supposedly good) PSU will show?

(Is this still on-topic on this list?)

Thanks a lot,
Jim
