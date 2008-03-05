From: "Christian Pernegger" <pernegger@gmail.com>
Subject: Re: Setting up md-raid5: observations, errors, questions
Date: Wed, 5 Mar 2008 07:38:35 +0100
Message-ID: <bb145bd20803042238y5c2d1164o8cac7be9880b550b@mail.gmail.com>
References: <bb145bd20803020423m14efea1by6e3e38bb8d0decb8@mail.gmail.com>
	 <47CAC5BF.6060600@msgid.tls.msk.ru>
	 <bb145bd20803020832x744c2674nd0a6a30e445b5453@mail.gmail.com>
	 <47CAF30F.7040502@msgid.tls.msk.ru>
	 <bb145bd20803021319o28df011sab954aa58a1c01be@mail.gmail.com>
	 <47CB228D.5020709@msgid.tls.msk.ru>
	 <bb145bd20803021617j1b15c667j96d3ee12829ee75a@mail.gmail.com>
	 <47CB694B.9000807@msgid.tls.msk.ru>
	 <bb145bd20803030038o905e1feib1c1ad42c1b4b042@mail.gmail.com>
	 <bb145bd20803040854i33796bb7n8de956b0d90b76d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:20999 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762534AbYCEGij (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Mar 2008 01:38:39 -0500
Received: by wr-out-0506.google.com with SMTP id 50so1898247wra.13
        for <linux-ide@vger.kernel.org>; Tue, 04 Mar 2008 22:38:36 -0800 (PST)
In-Reply-To: <bb145bd20803040854i33796bb7n8de956b0d90b76d9@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-raid@vger.kernel.org
Cc: linux-ide@vger.kernel.org

Added the dm-crypt layer back again, just to see what it would do:
- responsiveness problem is back
- performance is around the level of a single disk, if that

Played around some more and it seems that the system just reacts very
badly to some I/O loads. fs creation / bonnie on a resyncing RAID
apparently can trigger the same symptoms (even without dm-crypt),
though not all configurations.

Just for kicks I tried raid on dm-crypt, which doesn't have the
problem but is even slower.

Back to square one.

C.
