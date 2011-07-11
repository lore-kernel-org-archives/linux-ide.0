From: Pallav Bose <pallavbose@gmail.com>
Subject: NCQ queue management
Date: Mon, 11 Jul 2011 11:19:20 -0400
Message-ID: <CANk-0Yv1zbdKcZ-ABjpWjmsgqk1sPvfC2PBoKP6fNtF44QRKQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60450 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653Ab1GKPTk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Jul 2011 11:19:40 -0400
Received: by iwn6 with SMTP id 6so3740400iwn.19
        for <linux-ide@vger.kernel.org>; Mon, 11 Jul 2011 08:19:40 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Ganesh Karuppur Rajagopalan <ganesh.kr356@gmail.com>

Hello,

I'm working on 2.6.39.1. Is there a way to find out how many pending
requests are there in the NCQ queue? Is there a function that I can
use? For the purposes of my driver, I need a function --
num_pending_requests_NCQ() -- which would return the number of
requests that are currently in the NCQ queue. How should this function
be implemented?

Thanks,
Pallav
