Received: from o5.sg.zoom.us (o5.sg.zoom.us [149.72.199.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D02B35DD1C
	for <linux-ide@vger.kernel.org>; Fri, 13 Mar 2026 19:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.72.199.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773431188; cv=none; b=tgmT4EGlMVhq8TbIRksq9hCMWxNBhmD4h6Y3eTdYbrmwv44bxThuBZjcMXrvh/sVOHtHnAMq7INCBMJveBswCma//I0BFJqdMDIysRDLMck5s0GKkRC6pJJBY2Es5+z/FFIWWGzmgoz0EqXT7g2j1gEoXjGoigIaORj3koTTAzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773431188; c=relaxed/simple;
	bh=xu8T47c3TgjYIlGQBeR4dSFPAsHzNTFWKfkWUpUQ3Tw=;
	h=Content-Type:Date:From:Mime-Version:Message-ID:Subject:To; b=KVfNKZ9VEZeIoulwqsMBZRDfN4ZGgMvmwAwGF84opN9vScrOI8f/rdoADzFE0ZlPitC1b3dpfnz1ToyoF6P0CAG1Q2Ot8BhhifBEqzRbK7VP0gt8a9FCkgHcHvgPMHRFuCTMQPIE5KdCyTtr4WQ2jGXAl6D+/N/d5JeVDIbIwtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zoom.us; spf=pass smtp.mailfrom=bounce-sg.zoom.us; dkim=pass (2048-bit key) header.d=zoom.us header.i=@zoom.us header.b=TsU9Bd6c; arc=none smtp.client-ip=149.72.199.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zoom.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce-sg.zoom.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zoom.us header.i=@zoom.us header.b="TsU9Bd6c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zoom.us;
	h=content-type:date:from:mime-version:subject:reply-to:to:cc:
	content-type:date:from:subject:to;
	s=sg; t=1773431186; bh=+diMIeORP6p3O1e1mLblUyVHsosQIerhItAwL1p3xqc=;
	b=TsU9Bd6chH5+X7IFEFi1LCI69GSxrbvoRmlCPpKNCSOCUeL+TfzS9fKxTLHgAeq2rby8
	sk4xN+QOGVcNszfjfw/6w3MifXD4Q9lIV7UEaYGsUBFz12oS5bk6FAhArlUiC4a0xEax55
	t6bHbE/lZ4Ds4upQqVmxuJiu5JPC5UaFSt+WnrPCeD/vTX+2/kHZ5ck6T3D3OsPgjhHb/U
	zI4g9Bgwzu7usJPQwxVqZSdQ45kEYZayH6yXMm2XTlPt+OOHevyskqRXUcXFiTT9jUhQpo
	DHeJOk4QU9Z26rSJ8Pf80eWP+jWOv0fVlXrdCbU6KU/fkgAWQmwAuFxSHT+u97gQ==
Received: by recvd-7f966798cb-496nh with SMTP id recvd-7f966798cb-496nh-1-69B46992-28
	2026-03-13 19:46:26.336261258 +0000 UTC m=+347461.528197865
Received: from MjEwNzk4ODQ (unknown)
	by geopod-ismtpd-4 (SG) with HTTP
	id mUY2sPh6TVuNWXjBHPxEug
	Fri, 13 Mar 2026 19:46:26.309 +0000 (UTC)
Content-Type: multipart/mixed; boundary=4aaaef95c0beb83c634d80db861e95afcb4d5cd4a8ebd99978085b85da20
Date: Fri, 13 Mar 2026 19:46:26 +0000 (UTC)
From: Zoom Webinar <no-reply@zoom.us>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <mUY2sPh6TVuNWXjBHPxEug@geopod-ismtpd-4>
Subject: [TODAY @ 3 PM]: How AI =?UTF-8?B?4oCcVmlyYWwgQ2hhcmFjdGVyc+KAnQ==?=
 Are Pulling Millions of Views & Turning Short Videos Into Daily Sales
 Confirmation
Reply-To: Zoom Webinar <lanrejames@novalab.in>
Feedback-ID: j8lyLvjATyKTA8EMIQdvzA:::zoom.us
X-SG-EID: 
 =?us-ascii?Q?u001=2ERgZnWCz8IFHH0kIZpn+qAiw7pwkTVFI=2FJtjtfe++gnUbGuPWuWXXvMnuq?=
 =?us-ascii?Q?lWvvHeZe7tGaFmya1Lib5mab1OpH6+VbjG9rf4L?=
 =?us-ascii?Q?5PkMZy4=2FQUQMjA03=2FJdSeH0MM80gRnd9ICavavd?=
 =?us-ascii?Q?l6hzR0OyVPeXvkdW7gJrEoFFBPpih7cia37aKof?=
 =?us-ascii?Q?VUE1fiZI1nEKZtF=2FVAPh2GCfXQp50tcEorfm8Z1?=
 =?us-ascii?Q?YT6xBym5Xub4yaOZNvfQSdhfJ4C0GNCoBfw1Y6A?= =?us-ascii?Q?PPbJ?=
X-SG-ID: 
 =?us-ascii?Q?u001=2ESdBcvi+Evd=2FbQef8eZF3Bq+efGylwbz3q5X9xSK9XHyEixZMkOa8ilCgx?=
 =?us-ascii?Q?YOwpsXED6=2FoRQgRpyNwhJCp+NbSG4xP8sPpKkrO?=
 =?us-ascii?Q?K4yJNq1xr8196a7nn7YrEzKTMCJt7Z4IA8onDck?=
 =?us-ascii?Q?E9lNoaeGkNxcsxSalq9NKsZ+WkO2hukYlVi05Xh?=
 =?us-ascii?Q?VSx6SmEpqpNAxlpfPfHdaZnveMFHxJOn51r5LAs?=
 =?us-ascii?Q?u0TQ82tQV8gpC2L+EAs8uxufGnq6O1QKNML2yVA?=
 =?us-ascii?Q?r5UKHxKvl6FfZ1LaIqDhp=2F0IXcRcMi1uye4TY3X?=
 =?us-ascii?Q?lmZunt9VTQkap6JIl9UZtr+l+uZM50ZYsilf=2F+D?=
 =?us-ascii?Q?2ZuhMQK5oDbQ06mlpCjBcWPZo=2FijNnc+GEPTaoH?=
 =?us-ascii?Q?+qQ8wu0OKnbqg5rNcepiXCw66AFp+QfhoNzaIJ0?=
 =?us-ascii?Q?K6T1KZp9XNz8fFu+u5cwOlfmwDUOPPF0m7eY+6d?=
 =?us-ascii?Q?D8qeNb4S+FTDR9sXroX2Vm+ux0XDMHx7c5VtbDB?=
 =?us-ascii?Q?crAFhB3LVe+BuXOFJ8zzBPgPD7Rwym=2FQ31XHetU?=
 =?us-ascii?Q?r2QNZiEwVih5mh0dMVEmS=2Fv7w4B+YjEiNtQAJ5=2F?=
 =?us-ascii?Q?pWNlPfbyrpTMXqEJNG4A2bQ6udfLyP0M3dxBcS=2F?=
 =?us-ascii?Q?j6oTsHqNMmCDNY4mIsLghIVDD3SW1vWqS4Wfaua?=
 =?us-ascii?Q?6KAyVd3Q3AT4lRi7+benhtttcl7wSxQK6oI304x?=
 =?us-ascii?Q?wKjk+ViNDyV0EzkKw2WbgP1f4adVO8a8hvrMdPB?=
 =?us-ascii?Q?9wYq+3AFKgGbr4LBlsCH2LUe1VOpfiZxwFcoosb?=
 =?us-ascii?Q?cwXv3hOmb4zOHiTtuPwW9vPHiXLyqtgvbIT6lD8?=
 =?us-ascii?Q?ZuXW86WK7iqeBPSFJ2rbJJZd5zDDPJMwmWp0mxh?=
 =?us-ascii?Q?mKlCt4+lHwN0yPj68ff5qhkI8GzlFwqT9UMYA+s?=
 =?us-ascii?Q?=2FlNLsOZHaIjk=2F=2FsW38BCdb+A+X8hVotp8y0t9Ko?=
 =?us-ascii?Q?Cc5cK9mugrz3Fn8mYf7SVAIAN0rxg=2F+zEFPIAMd?=
 =?us-ascii?Q?viaSZ+sOkJ7VHwnefjoYFVBY3NcgUzHItg3Wgh8?=
 =?us-ascii?Q?Bi9rS29UZhSZjzHc29npH9OXcKZMS=2FgX2m16Y0J?=
 =?us-ascii?Q?RZ5ssXG=2FEzyb85hW9syXDnjtTFaforGaOwODWlP?=
 =?us-ascii?Q?EEwCCJ2fY0DaJOwIS?=
To: linux-ide@vger.kernel.org
X-Entity-ID: u001.D04ToUD6XUHaWjLaA2+xDg==

--4aaaef95c0beb83c634d80db861e95afcb4d5cd4a8ebd99978085b85da20
Content-Type: multipart/alternative; boundary=dd12e5cb658456e078a063b1ae52ad17716e9d139dace5c6009ad8b69e5e

--dd12e5cb658456e078a063b1ae52ad17716e9d139dace5c6009ad8b69e5e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=utf-8
Mime-Version: 1.0

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.=
w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns=3D"http://www.w3.org/1999/xhtml">
<head>
    <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Type=
"/>
</head>
<body style=3D"height: 100% !important;width: 100% !important;margin: 0;pad=
ding: 0;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" align=3D"center" bg=
color=3D"#f1f1f4" width=3D"100%" style=3D"font-size: 13px;font-family: Aria=
l;height:100%;">
    <tr>
        <td>
            <table id=3D"table-new-invitation" border=3D"0" cellpadding=3D"=
0" cellspacing=3D"0" align=3D"center" style=3D"padding: 40px 0;max-width: 9=
60px;min-width: 600px;width: 60%;">
                    <tr><td style=3D"height: 8px;"></td> </tr>
                <tr>
                    <td valign=3D"top" bgcolor=3D"#ffffff">
                        <table border=3D"0" cellpadding=3D"0" cellspacing=
=3D"0" align=3D"center" width=3D"100%" style=3D"margin-left: 0;margin-right=
: 0;">
                            <tr>
                                <td style=3D"padding-left: 32px;padding-rig=
ht: 32px;">
                                    <table border=3D"0" cellpadding=3D"0" c=
ellspacing=3D"0" align=3D"center" width=3D"100%" style=3D"font-size: 13px;c=
olor: #39394d;font-family: Arial;">
                                        <tr> <td colspan=3D"2" valign=3D"to=
p" style=3D"padding-top:32px;font-size: 14px;font-weight: 400;color: #13161=
9;font-family: Arial;line-height: 24px;">Hi  Friend,</td> </tr>
                                        <tr> <td colspan=3D"2" valign=3D"to=
p" style=3D"padding-top:32px;font-size: 14px;font-weight: 400;color: #13161=
9;font-family: Arial;line-height: 24px;">Thank you for registering for [TOD=
AY @ 3 PM]<span>:</span> How AI =E2=80=9CViral Characters=E2=80=9D Are Pull=
ing Millions of Views &amp; Turning Short Videos Into Daily Sales. You can =
find information about this webinar below.</td> </tr>
                                        <tr><td style=3D"height: 32px"></td=
></tr>
                                        <tr><td style=3D"height: 32px"></td=
></tr>
                                            <tr> <td colspan=3D"2" valign=
=3D"top" style=3D"font-size: 14px;font-weight: 400;color: #131619;font-fami=
ly: Arial;line-height: 24px;"> Please submit any questions to: <a target=3D=
"_blank" style=3D"color: #000000;text-decoration:none;"> lanrejames@novalab=
.in</a> </td> </tr>
                                        <tr><td style=3D"height: 32px"></td=
></tr>
                                            <tr> <td colspan=3D"2" style=3D=
"font-size: 14px;font-weight: 400;color: #000;font-family: Arial;line-heigh=
t: 24px;" valign=3D"top"> You can <a href=3D"https://zoom.us/webinar/regist=
er/WN_7OWkX7BxTwuKEaEuvulYxA?tk=3DhX4fhDAluIWpuSGM6z6nQ0pFWe8C5LFoY7o7zRmbg=
8k.DQkAAAAVfMDRTRZNY25QWWdLSFFNV3dONDNXajdHaXdnAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAA#detail" target=3D"_blank">cancel</a> your registration at a=
ny time. </td> </tr>
                                        <tr><td style=3D"height: 32px"></td=
></tr>
                                        <tr> <td colspan=3D"2" style=3D"fon=
t-size: 14px;font-weight: 400;color: #000;font-family: Arial;line-height: 2=
4px;" valign=3D"top"> Thank you! </td> </tr>
                                        <tr>
                                            <td width=3D"100%">
                                                <table style=3D"width:100%;=
border-radius: 8px;background-color: #F7F7FC;">
                                                        <tr> <td colspan=3D=
"3" style=3D"padding: 12px 16px 8px 16px;font-size: 14px;font-weight: 700;l=
ine-height: 24px;" valign=3D"top">  <strong>[TODAY @ 3 PM]<span>:</span> Ho=
w AI =E2=80=9CViral Characters=E2=80=9D Are Pulling Millions of Views &amp;=
 Turning Short Videos Into Daily Sales</strong> </td> </tr>
                                                            <tr>
                                                                <td valign=
=3D"top" style=3D"padding: 4px 16px 8px 16px;width: 112px;font-size: 13px;f=
ont-weight: 400;line-height: 16px;color: rgba(4, 4, 19, 0.56);">Date & Time=
</td>
                                                                <td valign=
=3D"top" style=3D"font-weight: 400;font-size: 13px;line-height: 16px;color:=
 #233333;padding: 4px 16px 8px 0;">Mar 13, 2026 03:00 PM Eastern Time (US a=
nd Canada)</td>
                                                            </tr>
                                                        <tr>
                                                            <td valign=3D"t=
op" style=3D"padding: 4px 16px 8px 16px;width: 112px;font-size: 13px;font-w=
eight: 400;line-height: 16px;color: rgba(4, 4, 19, 0.56);">Webinar ID</td>
                                                            <td valign=3D"t=
op" style=3D"font-weight: 400;font-size: 13px;line-height: 16px;color: #233=
333;padding: 4px 16px 8px 0;">922 8732 4493</td>
                                                        </tr>
                                                        <tr>
                                                            <td valign=3D"t=
op" style=3D"padding: 4px 16px 8px 16px;width: 112px;font-size: 13px;font-w=
eight: 400;line-height: 16px;color: rgba(4, 4, 19, 0.56);">Description</td>
                                                            <td valign=3D"t=
op" style=3D"font-weight: 400;font-size: 13px;line-height: 16px;color: #233=
333;padding: 4px 16px 8px 0;">Something BIG is about to hit the AI content =
creation space=E2=80=A6<br/>
<br/>
For the first time ever, you=E2=80=99re about to discover a powerful system=
 that lets anyone create viral AI character videos in minutes without compl=
icated editing, animation skills, or expensive software.<br/>
<br/>
Inside this live training, you=E2=80=99ll see how simple ideas, scripts, or=
 images can instantly be transformed into fully animated character videos w=
ith voiceovers, expressions, and storytelling built in automatically.<br/>
<br/>
These character-driven videos are dominating social platforms because audie=
nces connect with characters far more than ordinary content, which is why c=
reators are generating massive engagement using this format.<br/>
<br/>
During this LIVE session, you=E2=80=99ll discover:<br/>
<br/>
=E2=80=A2 How AI characters can instantly generate engaging videos for TikT=
ok, Instagram Reels, and YouTube Shorts<br/>
=E2=80=A2 The simple workflow that transforms ideas, images, or scripts int=
o animated viral videos<br/>
=E2=80=A2 How character-based content grabs attention and keeps viewers wat=
ching longer<br/>
=E2=80=A2 The strategy behind viral character storytelling that drives shar=
es and engagement<br/>
=E2=80=A2 How beginners are using AI characters to create entertaining, hig=
hly shareable videos at scale<br/>
<br/>
You=E2=80=99ll also see a live demo showing exactly how these AI characters=
 can speak, react, and tell stories while automatically syncing voice, expr=
essions, and scenes.<br/>
<br/>
If you want to learn how the new wave of AI-powered viral character videos =
are being created=E2=80=A6<br/>
<br/>
you won=E2=80=99t want to miss this training.<br/>
<br/>
=E2=9A=A0=EF=B8=8F IMPORTANT =E2=80=94 Secure Your Reminder Now!<br/>
<br/>
This is a live training and space is limited.<br/>
<br/>
To make sure you don=E2=80=99t miss it:<br/>
<br/>
=E2=9C=85 Click =E2=80=9CAdd to Calendar=E2=80=9D below to save the event t=
o your Google / Outlook calendar.<br/>
<br/>
Your device will automatically remind you before we go live.<br/>
<br/>
Most people miss live trainings simply because they forget.<br/>
<br/>
Don=E2=80=99t be that person.</td>
                                                        </tr>
                                                    <tr>
                                                        <td style=3D"paddin=
g: 8px 16px 0;width: 112px;"></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr><td style=3D"height: 8px;"></td=
> </tr>
                                            <tr> <td colspan=3D"2" style=3D=
"line-height: 32px;padding-top: 16px;padding-bottom: 30px;"> <span style=3D=
"font-size: 14px;font-weight: bold;line-height: 20px;color: #222230;vertica=
l-align: middle;">Add to:</span>  <a href=3D"https://zoom.us/webinar/tJYvf-=
6rrD8uE9cVJcfwBOyFHAZcfcmFSa8i/calendar/google/add?user_id=3DBQx1aRloTxoh9C=
vJ_N7KTItmj1dKL4Uzd6_I7Sk7FJxk7qbJJuc.Xzr5bkV8I5MZFE11&type=3Dgoogle" style=
=3D"letter-spacing: 0;border: 1px solid #3171BB;color: #3171BB;border-radiu=
s: 8px;padding: 3px 5px;text-decoration: none;font-weight: 400;font-size: 1=
4px;line-height: 30px;height: 24px;display:inline-flex;vertical-align:middl=
e;"> <i class=3D"glyphicon" style=3D"width: 20px;display:inline-block;"> <i=
mg src=3D"https://st3.zoom.us/static/6.3.53910/image/new/google.png" /> </i=
><span style=3D"display:inline-flex;line-height:24px;">&nbsp;Google Calenda=
r</span> </a>&nbsp;  <a href=3D"https://zoom.us/webinar/tJYvf-6rrD8uE9cVJcf=
wBOyFHAZcfcmFSa8i/ics?user_id=3Dd4MqQm9gjJRyZsi5hTJlWdMu78Huu-y4o_200u5rwhd=
bjcEr6y8.L3u2UUlE85W-P0Kq&type=3Dicalendar" style=3D"border: 1px solid #0E7=
2ED;color: #0E72ED;border-radius: 8px;padding:3px 5px;text-decoration: none=
;font-weight: 400;font-size: 14px;line-height: 30px;vertical-align:middle;h=
eight: 24px;display:inline-flex;letter-spacing: 0;"> <i class=3D"glyphicon"=
 style=3D"width: 20px;display:inline-block;"> <img src=3D"https://st3.zoom.=
us/static/6.3.53910/image/new/outlook.png" /> </i><span style=3D"display:in=
line-flex;line-height:24px;">&nbsp;Outlook Calendar(.ICS)</span> </a>&nbsp;=
 <a href=3D"https://zoom.us/webinar/tJYvf-6rrD8uE9cVJcfwBOyFHAZcfcmFSa8i/ic=
s?user_id=3DO3mPU-j4-_hTDsX4zoz1oPA-JGVT-ShT7VDUcVOjmAyvPOBFoSc.k_utYk3o4ly=
6WA0p&type=3Dyahoo" style=3D"border: 1px solid #952BCE;color: #952BCE;borde=
r-radius: 8px;padding: 3px 5px;text-decoration: none;font-weight: 400;font-=
size: 14px;line-height: 30px;vertical-align:middle;height: 24px;display:inl=
ine-flex;letter-spacing: 0;"> <i class=3D"glyphicon" style=3D"width: 20px;d=
isplay:inline-block;"> <img src=3D"https://st3.zoom.us/static/6.3.53910/ima=
ge/new/yahoo.png" /> </i><span style=3D"display:inline-flex;line-height:24p=
x;">&nbsp;Yahoo Calendar</span> </a> </td> </tr>
                                        <tr></tr>
                                        <tr> <td> <table align=3D"left" cel=
lpadding=3D"0" cellspacing=3D"0" style=3D"width:100%;"> <tr> <td bgcolor=3D=
"#ffffff" style=3D"padding: 32px 0 0 0;padding-top: 30px !important;width: =
182px;font-size: 12px;line-height: 18px;color: rgba(4, 4, 19, 0.56);font-we=
ight: 700;" valign=3D"top"> WAYS TO JOIN THIS WEBINAR </td> <td bgcolor=3D"=
#ffffff" style=3D"padding: 32px 0 0 8px;padding-top: 38px !important;" vali=
gn=3D"top"> <div style=3D"height: 1px;border-top: 1px dashed rgba(82, 82, 1=
28, 0.18);"></div> </td> </tr> </table> </td> </tr>
                                        <tr> <td colspan=3D"2" style=3D"pad=
ding-left:12px;padding-top: 28px !important;padding-bottom: 12px !important=
;font-family: Arial;font-size: 16px;font-weight: 700;line-height: 24px;colo=
r: #233333;" valign=3D"top"> <ul style=3D"padding:0;margin:0;"><li class=3D=
"join1" style=3D"margin-left:0;list-style-type: disc;">Join from PC, Mac, i=
Pad, or Android</li></ul> </td> </tr>
                                            <tr> <td bgcolor=3D"#ffffff" wi=
dth=3D"122" height=3D"30" style=3D"padding-bottom: 16px;" valign=3D"middle"=
> <div style=3D"height: 24px;border-radius: 8px;line-height: 30px;mso-line-=
height-rule: exactly;"> <a type=3D"button" href=3D"https://zoom.us/w/922873=
24493?tk=3DhX4fhDAluIWpuSGM6z6nQ0pFWe8C5LFoY7o7zRmbg8k.DQkAAAAVfMDRTRZNY25Q=
WWdLSFFNV3dONDNXajdHaXdnAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA&uuid=3D=
WN_7OWkX7BxTwuKEaEuvulYxA" target=3D"_blank" style=3D"height:24px;text-deco=
ration:none;font-size: 14px;font-weight: 500;color: #fff;background: #0E72E=
D;border-radius: 8px;line-height: 30px;vertical-align:middle;padding: 7px 2=
0px;mso-line-height-rule:exactly;">&nbsp;&nbsp;&nbsp;&nbsp;<span style=3D"l=
ine-height:30px;mso-line-height-rule:exactly;">Join Webinar</span>&nbsp;&nb=
sp;&nbsp;&nbsp;</a> </div> </td> </tr>
                                            <tr> <td colspan=3D"2" valign=
=3D"top" style=3D"font-size: 14px;font-weight: 400;color: #000000;font-fami=
ly: Arial;line-height: 24px;"> If the button above does not work, paste thi=
s into your browser:=E2=80=A8<br/> </td> </tr>
                                            <tr> <td colspan=3D"2" valign=
=3D"top" width=3D"536" style=3D"word-break: break-all;font-size: 14px;font-=
weight: 400;color: #000000;font-family: Arial;line-height: 24px;"> <a href=
=3D"https://zoom.us/w/92287324493?tk=3DhX4fhDAluIWpuSGM6z6nQ0pFWe8C5LFoY7o7=
zRmbg8k.DQkAAAAVfMDRTRZNY25QWWdLSFFNV3dONDNXajdHaXdnAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAA&uuid=3DWN_7OWkX7BxTwuKEaEuvulYxA" style=3D"width: 536p=
x;text-decoration:underline;color: #000000;word-wrap:break-word;">https://z=
oom.us/w/92287324493?tk=3DhX4fhDAluIWpuSGM6z6nQ0pFWe8C5LFoY7o7zRmbg8k.DQkAA=
AAVfMDRTRZNY25QWWdLSFFNV3dONDNXajdHaXdnAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAA&uuid=3DWN_7OWkX7BxTwuKEaEuvulYxA</a> </td> </tr>
                                        <tr> <td colspan=3D"2" style=3D"fon=
t-family: Arial;font-size: 14px;font-weight: 700;line-height: 17px;color: #=
222230;padding-top: 12px;" valign=3D"top"> To keep this webinar secure, do =
not share this link publicly. </td> </tr>
                                                <tr>
                                                    <td width=3D"100%">
                                                        <table align=3D"lef=
t" border=3D"0" cellpadding=3D"0" cellspacing=3D"0" style=3D"width:auto;pad=
ding:0;margin:0;">
                                                            <tr> <td colspa=
n=3D"2" valign=3D"top" style=3D"padding:32px 0 8px 12px;font-family: Arial;=
font-size: 16px;font-weight: 700;line-height: 24px;color: #233333;"> <ul st=
yle=3D"padding:0;margin:0;"><li style=3D"margin-left:0;list-style-type: dis=
c;">Join via audio</li></ul> </td> </tr>
                                                            <tr> <td width=
=3D"600" colspan=3D"2" valign=3D"top" style=3D"word-break: break-word;paddi=
ng-bottom: 4px;font-size: 14px;font-weight: 400;color: #233333;font-family:=
 Arial;line-height: 24px;"> <span style=3D"color: #000000;word-wrap: break-=
word;"> US: <a style=3D"color: #233333;text-decoration: underline;" href=3D=
"tel:+13462487799,,92287324493#">+13462487799,,92287324493#</a>   or <a sty=
le=3D"color: #233333;text-decoration: underline;" href=3D"tel:+13602095623,=
,92287324493#">+13602095623,,92287324493#</a>  </span> </td> </tr>
                                                            <tr> <td style=
=3D"width: 100px;padding-left: 0;padding-right: 6px;font-weight: 600;font-s=
ize: 14px;color: #233333;font-family: Arial;line-height: 24px;" valign=3D"t=
op"> Or, dial: </td> <td width=3D"836" style=3D"word-break: break-word;padd=
ing-left: 0;padding-bottom: 4px;font-size: 14px;font-weight: 400;color: #23=
3333;font-family: Arial;line-height: 24px;" valign=3D"top"> <span style=3D"=
color: #000000;word-wrap: break-word;">    US:  +1 346 248 7799      or +1 =
360 209 5623      or +1 386 347 5053      or +1 507 473 4847      or +1 564=
 217 2000      or +1 646 931 3860      or +1 669 444 9171      or +1 669 90=
0 6833      or +1 689 278 1000      or +1 719 359 4580      or +1 929 205 6=
099      or +1 253 205 0468      or +1 253 215 8782      or +1 301 715 8592=
      or +1 305 224 1968      or +1 309 205 3325      or +1 312 626 6799   =
  <br><a href=3D"https://zoom.us/u/ac9hEmcTMT" target=3D"_blank" style=3D"f=
ont-size: 14px;font-weight: 400;color: #233333;font-family: Arial;line-heig=
ht: 24px;vertical-align: top;">More International numbers</a>  </span> </td=
> </tr>
                                                                <tr> <td va=
lign=3D"top" style=3D"width: auto;padding-left: 0;padding-right: 6px;font-s=
ize: 14px;font-weight: 400;color: #233333;font-family: Arial;line-height: 2=
4px;">Webinar ID:</td> <td style=3D"padding-left:0;padding-bottom: 4px;font=
-size: 14px;font-weight: 400;color: #233333;font-family: Arial;line-height:=
 24px;" valign=3D"top">922 8732 4493</td> </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                       =20
                                       =20
                                       =20
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td height=3D"32"></td>
                            </tr>
                            <tr><td style=3D"padding-top: 32px;padding-left=
: 32px;padding-right: 32px;"><div style=3D"height: 1px; border-top-width: 1=
px; border-top-style: inset; border-top-color: #DFE3E8;"></div></td></tr>
                            <tr>
                                <td style=3D"padding-top: 24px;padding-bott=
om: 24px;">
                                    <table align=3D"center" border=3D"0" ce=
llpadding=3D"0" cellspacing=3D"0" style=3D"width:auto;">
                                        <tbody>
                                        <tr>
                                            <td style=3D"padding:0;"> <a hr=
ef=3D"https://linkedin.com/company/zoom/" class=3D"no-decortaion" style=3D"=
margin-right: 16px;"> <img alt=3D"" border=3D"0" width=3D"32" height=3D"32"=
 src=3D"https://file-paa.zoom.us/kNH2urxhRLqXnWNb_EN1lQ/MS4yLoS79VBM36fz9x0=
Qu-Vm3_05uKEgidDZkSkBh6nf5jHh/Linkedin.png" style=3D"border-width: 0px;bord=
er-style: solid;width: 32px;height: 32px;" /> </a> </td>
                                            <td style=3D"padding:0;"> <a hr=
ef=3D"https://twitter.com/zoom" class=3D"no-decortaion" style=3D"margin-rig=
ht: 16px;"> <img alt=3D"" border=3D"0" width=3D"32" height=3D"32" src=3D"ht=
tps://file-paa.zoom.us/A9z6enYnRciVty2WD69K5Q/MS4yLlA3EEXVxtd5BnQvHzaVmWfiw=
_MyODrLSm1FTgct1k_x/X.png" style=3D"border-width: 0px;border-style: solid;w=
idth: 32px;height: 32px;" /> </a> </td>
                                            <td style=3D"padding:0;"> <a hr=
ef=3D"https://instagram.com/zoom" class=3D"no-decortaion" style=3D"margin-r=
ight: 16px;"> <img alt=3D"" border=3D"0" width=3D"32" height=3D"32" src=3D"=
https://file-paa.zoom.us/6OcdBBJUSUO39GlRevwBpw/MS4yLhjC22e6R_ad3qd4NWLCKth=
WlIu8Y716iX4jSiBD42Rx/Instagram.png" style=3D"border-width: 0px;border-styl=
e: solid;width: 32px;height: 32px;" /> </a> </td>
                                            <td style=3D"padding:0;"> <a hr=
ef=3D"https://www.facebook.com/zoom" style=3D"text-decoration: none;margin-=
right: 16px;"> <img alt=3D"" border=3D"0" width=3D"32" height=3D"32" src=3D=
"https://file-paa.zoom.us/XiUNdDxVRN227pWtZejqng/MS4yLjBX8SUlVoub9cJv-VllS5=
alt7U-cZRNnpyJTwbWNBPX/Facebook.png" style=3D"border-width: 0px;border-styl=
e: solid;width: 32px;height: 32px;" /> </a> </td>
                                            <td style=3D"padding:0;"> <a hr=
ef=3D"https://www.youtube.com/@Zoom" style=3D"text-decoration: none;margin-=
right: 16px;"> <img alt=3D"" border=3D"0" width=3D"32" height=3D"32" src=3D=
"https://file-paa.zoom.us/AQII00caTNmcRtOxZA9CHw/MS4yLluoNlumbwBzheCXQU4wTL=
FvBAvxtt0j2Se_SPtGrimT/YouTube.png" style=3D"border-width: 0px;border-style=
: solid;width: 32px;height: 32px;" /> </a> </td>
                                            <td style=3D"padding:0;"> <a hr=
ef=3D"https://blog.zoom.us/" style=3D"text-decoration: none;"> <img alt=3D"=
" border=3D"0" width=3D"32" height=3D"32" src=3D"https://file-paa.zoom.us/y=
3B837SCRhewJhRfIQAbNQ/MS4yLjSNE-R1r6XOy5Splz-i8Kl5uvaFt1JIWRutwY3W9uAP/Blog=
.png" style=3D"border-width: 0px;border-style: solid;width: 32px;height: 32=
px;" /> </a> </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <table align=3D"center" border=3D"0" ce=
llpadding=3D"0" cellspacing=3D"0" width=3D"100%" style=3D"margin-top: 16px;=
color:#6E7680;font-size: 12px;line-height: 16px;font-weight: 400;">
                                        <tbody>
                                        <tr> <td align=3D"center" style=3D"=
font-size:12px;font-weight: 400;line-height:16px;color:#747487;" valign=3D"=
top"> <a style=3D"color: #0D6BDE; font-size: 14px;font-style: normal;font-w=
eight: 590;line-height: 18px;text-decoration:none; letter-spacing: -0.15px;=
">Zoom.com</a> <br> <a style=3D"color: #2A2B2D; font-size: 10px; font-style=
: normal;font-weight: 400;line-height: 16px;text-decoration:none; letter-sp=
acing: 0.12px;" target=3D"_blank"> 55 Almaden Blvd<br> San Jose, CA 95113</=
a> </td> </tr>
                                        <tr> <td align=3D"center"style=3D"p=
adding: 16px 0 0;font-size:12px;font-weight: 400;line-height:16px;color:#74=
7487;" valign=3D"top"> <a href=3D"tel:1-888-799-9666" style=3D"color: #0D6B=
DE; text-decoration: none; font-size: 14px; font-style: normal;font-weight:=
 590;line-height: 18px; letter-spacing: -0.15px;">+1.888.799.9666</a> <br> =
</td> </tr>
                                        <tr> <td align=3D"center"style=3D"f=
ont-size:12px;font-weight: 400;line-height:16px;color:#747487;" valign=3D"t=
op"> <a style=3D"color:#686F79;margin:0;font-size:10px; font-weight: 400;li=
ne-height: 16px;text-decoration: none; letter-spacing: 0.12px;" target=3D"_=
blank">&copy;2026 Zoom Communications, Inc.</a> <br> </td> </tr>
                                        </tbody>
                                    </table>

                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</body>
</html>

<html xmlns=3D"http://www.w3.org/1999/xhtml">
<head>
    <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Type=
"/>
</head>
<body style=3D"height: 100% !important;width: 100% !important;margin: 0;pad=
ding: 0;">
            <table align=3D"center" border=3D"0" cellpadding=3D"0" cellspac=
ing=3D"0" width=3D"100%" style=3D"padding-top: 16px;">
            <tbody>
                <tr>
                    <td align=3D"center" style=3D"padding-top:16px;padding-=
left: 32px;padding-right: 32px;color:#6e7680;font-size:18px;line-height:22p=
x;font-weight:400" valign=3D"top">
                        <a style=3D"color:#6E7680;text-decoration: none;" t=
arget=3D"_blank">
                            To unsubscribe, [<a href=3D'https://zoom.us/web=
inar/email/3184ad23-db8d-471d-93c5-d6839dac2f92/unsubscribe?email=3DDLvXlHz=
vV1AHIZdcNgAAGQAAABASDSu2jDgVic6yzv1vjdS3LOqBhKOpmJ9PoDvu72pUdtcqmRzQEAJpMD=
AwMDAx&amp;host=3DDB-gMQwItyHvHutQQgAAFQAAAEQUaLp8Fx5m5VjUOzpSrRy-p_e8Kbpk4=
of0LX7k7cQPtUCXlnowMDAwMDE&amp;language=3Den-US&amp;view=3Dfalse'>Click her=
e</a>]
                        </a>
                    </td>
                </tr>
            </tbody>
        </table>
</body>
</html>
--dd12e5cb658456e078a063b1ae52ad17716e9d139dace5c6009ad8b69e5e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/calendar; method=REQUEST;; charset=UTF-8
Mime-Version: 1.0

BEGIN:VCALENDAR
PRODID:-//zoom.us//iCalendar Event//EN
VERSION:2.0
CALSCALE:GREGORIAN
METHOD:REQUEST
BEGIN:VTIMEZONE
TZID:America/New_York
LAST-MODIFIED:20260306T231828Z
TZURL:https://www.tzurl.org/zoneinfo-outlook/America/New_York
X-LIC-LOCATION:America/New_York
BEGIN:DAYLIGHT
TZNAME:EDT
TZOFFSETFROM:-0500
TZOFFSETTO:-0400
DTSTART:19700308T020000
RRULE:FREQ=3DYEARLY;BYMONTH=3D3;BYDAY=3D2SU
END:DAYLIGHT
BEGIN:STANDARD
TZNAME:EST
TZOFFSETFROM:-0400
TZOFFSETTO:-0500
DTSTART:19701101T020000
RRULE:FREQ=3DYEARLY;BYMONTH=3D11;BYDAY=3D1SU
END:STANDARD
END:VTIMEZONE
BEGIN:VEVENT
DTSTAMP:20260313T192515Z
DTSTART;TZID=3DAmerica/New_York:20260313T150000
DTEND;TZID=3DAmerica/New_York:20260313T160000
SUMMARY:[TODAY @ 3 PM]: How AI =E2=80=9CViral Characters=E2=80=9D Are Pullin=
g Millions of Views & Turning Short Videos Into Daily Sales
UID:b97kuj9p68p3gdpj68q38e9jdhkmstbo5lkm8pa0epjmasheddin4rj5dgn6usj7
TZID:America/New_York
DESCRIPTION:Topic: [TODAY @ 3 PM]: How AI =E2=80=9CViral Characters=E2=80=9D=
 Are Pulling Millions of Views & Turning Short Videos Into Daily Sales\nDesc=
ription: Something BIG is about to hit the AI content creation space=E2=80=
=A6\n\nFor the first time ever\, you=E2=80=99re about to discover a powerful=
 system that lets anyone create viral AI character videos in minutes without=
 complicated editing\, animation skills\, or expensive software.\n\nInside t=
his live training\, you=E2=80=99ll see how simple ideas\, scripts\, or image=
s can instantly be transformed into fully animated character videos with voi=
ceovers\, expressions\, and storytelling built in automatically.\n\nThese ch=
aracter-driven videos are dominating social platforms because audiences conn=
ect with characters far more than ordinary content\, which is why creators a=
re generating massive engagement using this format.\n\nDuring this LIVE sess=
ion\, you=E2=80=99ll discover:\n\n=E2=80=A2 How AI characters can instantly =
generate engaging videos for TikTok\, Instagram Reels\, and YouTube Shorts\n=
=E2=80=A2 The simple workflow that transforms ideas\, images\, or scripts in=
to animated viral videos\n=E2=80=A2 How character-based content grabs attent=
ion and keeps viewers watching longer\n=E2=80=A2 The strategy behind viral c=
haracter storytelling that drives shares and engagement\n=E2=80=A2 How begin=
ners are using AI characters to create entertaining\, highly shareable video=
s at scale\n\nYou=E2=80=99ll also see a live demo showing exactly how these =
AI characters can speak\, react\, and tell stories while automatically synci=
ng voice\, expressions\, and scenes.\n\nIf you want to learn how the new wav=
e of AI-powered viral character videos are being created=E2=80=A6\n\nyou won=
=E2=80=99t want to miss this training.\n\n=E2=9A=A0=EF=B8=8F IMPORTANT =E2=
=80=94 Secure Your Reminder Now!\n\nThis is a live training and space is lim=
ited.\n\nTo make sure you don=E2=80=99t miss it:\n\n=E2=9C=85 Click =E2=80=
=9CAdd to Calendar=E2=80=9D below to save the event to your Google / Outlook=
 calendar.\n\nYour device will automatically remind you before we go live.\n=
\nMost people miss live trainings simply because they forget.\n\nDon=E2=80=
=99t be that person.\n\nJoin from PC\, Mac\, iPad\, or Android:\nhttps://zoo=
m.us/w/92287324493?tk=3DhX4fhDAluIWpuSGM6z6nQ0pFWe8C5LFoY7o7zRmbg8k.DQkAAAAV=
fMDRTRZNY25QWWdLSFFNV3dONDNXajdHaXdnAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAA&uuid=3DWN_7OWkX7BxTwuKEaEuvulYxA\n\nPhone one-tap:\n+13462487799\,\,9228=
7324493# US (Houston)\n+13602095623\,\,92287324493# US\n\nJoin via audio:\n+=
1 346 248 7799 US (Houston)\n+1 360 209 5623 US\n+1 386 347 5053 US\n+1 507 =
473 4847 US\n+1 564 217 2000 US\n+1 646 931 3860 US\n+1 669 444 9171 US\n+1 =
669 900 6833 US (San Jose)\n+1 689 278 1000 US\n+1 719 359 4580 US\n+1 929 2=
05 6099 US (New York)\n+1 253 205 0468 US\n+1 253 215 8782 US (Tacoma)\n+1 3=
01 715 8592 US (Washington DC)\n+1 305 224 1968 US\n+1 309 205 3325 US\n+1 3=
12 626 6799 US (Chicago)\nWebinar ID: 922 8732 4493\nInternational numbers a=
vailable: https://zoom.us/u/ac9hEmcTMT\n\n\n
LOCATION:https://zoom.us/w/92287324493?tk=3DhX4fhDAluIWpuSGM6z6nQ0pFWe8C5LFo=
Y7o7zRmbg8k.DQkAAAAVfMDRTRZNY25QWWdLSFFNV3dONDNXajdHaXdnAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAA&uuid=3DWN_7OWkX7BxTwuKEaEuvulYxA
SEQUENCE:1773423967
ORGANIZER;ROLE=3DREQ-PARTICIPANT;CN=3DZoom Webinar:no-reply@zoom.us
ATTENDEE;ROLE=3DREQ-PARTICIPANT;CN=3DFriend:mailto:linux-ide@vger.kernel.org
BEGIN:VALARM
TRIGGER:-PT10M
ACTION:DISPLAY
DESCRIPTION:Reminder
END:VALARM
END:VEVENT
END:VCALENDAR

--dd12e5cb658456e078a063b1ae52ad17716e9d139dace5c6009ad8b69e5e--

--4aaaef95c0beb83c634d80db861e95afcb4d5cd4a8ebd99978085b85da20
Content-Disposition: attachment; filename="invite.ics"
Content-Transfer-Encoding: base64
Content-Type: text/calendar; name="invite.ics"

QkVHSU46VkNBTEVOREFSDQpQUk9ESUQ6LS8vem9vbS51cy8vaUNhbGVuZGFyIEV2ZW50Ly9FTg0K
VkVSU0lPTjoyLjANCkNBTFNDQUxFOkdSRUdPUklBTg0KTUVUSE9EOlJFUVVFU1QNCkJFR0lOOlZU
SU1FWk9ORQ0KVFpJRDpBbWVyaWNhL05ld19Zb3JrDQpMQVNULU1PRElGSUVEOjIwMjYwMzA2VDIz
MTgyOFoNClRaVVJMOmh0dHBzOi8vd3d3LnR6dXJsLm9yZy96b25laW5mby1vdXRsb29rL0FtZXJp
Y2EvTmV3X1lvcmsNClgtTElDLUxPQ0FUSU9OOkFtZXJpY2EvTmV3X1lvcmsNCkJFR0lOOkRBWUxJ
R0hUDQpUWk5BTUU6RURUDQpUWk9GRlNFVEZST006LTA1MDANClRaT0ZGU0VUVE86LTA0MDANCkRU
U1RBUlQ6MTk3MDAzMDhUMDIwMDAwDQpSUlVMRTpGUkVRPVlFQVJMWTtCWU1PTlRIPTM7QllEQVk9
MlNVDQpFTkQ6REFZTElHSFQNCkJFR0lOOlNUQU5EQVJEDQpUWk5BTUU6RVNUDQpUWk9GRlNFVEZS
T006LTA0MDANClRaT0ZGU0VUVE86LTA1MDANCkRUU1RBUlQ6MTk3MDExMDFUMDIwMDAwDQpSUlVM
RTpGUkVRPVlFQVJMWTtCWU1PTlRIPTExO0JZREFZPTFTVQ0KRU5EOlNUQU5EQVJEDQpFTkQ6VlRJ
TUVaT05FDQpCRUdJTjpWRVZFTlQNCkRUU1RBTVA6MjAyNjAzMTNUMTkyNTE1Wg0KRFRTVEFSVDtU
WklEPUFtZXJpY2EvTmV3X1lvcms6MjAyNjAzMTNUMTUwMDAwDQpEVEVORDtUWklEPUFtZXJpY2Ev
TmV3X1lvcms6MjAyNjAzMTNUMTYwMDAwDQpTVU1NQVJZOltUT0RBWSBAIDMgUE1dOiBIb3cgQUkg
4oCcVmlyYWwgQ2hhcmFjdGVyc+KAnSBBcmUgUHVsbGluZyBNaWxsaW9ucyBvZiBWaWV3cyAmIFR1
cm5pbmcgU2hvcnQgVmlkZW9zIEludG8gRGFpbHkgU2FsZXMNClVJRDpiOTdrdWo5cDY4cDNnZHBq
NjhxMzhlOWpkaGttc3RibzVsa204cGEwZXBqbWFzaGVkZGluNHJqNWRnbjZ1c2o3DQpUWklEOkFt
ZXJpY2EvTmV3X1lvcmsNCkRFU0NSSVBUSU9OOlRvcGljOiBbVE9EQVkgQCAzIFBNXTogSG93IEFJ
IOKAnFZpcmFsIENoYXJhY3RlcnPigJ0gQXJlIFB1bGxpbmcgTWlsbGlvbnMgb2YgVmlld3MgJiBU
dXJuaW5nIFNob3J0IFZpZGVvcyBJbnRvIERhaWx5IFNhbGVzXG5EZXNjcmlwdGlvbjogU29tZXRo
aW5nIEJJRyBpcyBhYm91dCB0byBoaXQgdGhlIEFJIGNvbnRlbnQgY3JlYXRpb24gc3BhY2XigKZc
blxuRm9yIHRoZSBmaXJzdCB0aW1lIGV2ZXJcLCB5b3XigJlyZSBhYm91dCB0byBkaXNjb3ZlciBh
IHBvd2VyZnVsIHN5c3RlbSB0aGF0IGxldHMgYW55b25lIGNyZWF0ZSB2aXJhbCBBSSBjaGFyYWN0
ZXIgdmlkZW9zIGluIG1pbnV0ZXMgd2l0aG91dCBjb21wbGljYXRlZCBlZGl0aW5nXCwgYW5pbWF0
aW9uIHNraWxsc1wsIG9yIGV4cGVuc2l2ZSBzb2Z0d2FyZS5cblxuSW5zaWRlIHRoaXMgbGl2ZSB0
cmFpbmluZ1wsIHlvdeKAmWxsIHNlZSBob3cgc2ltcGxlIGlkZWFzXCwgc2NyaXB0c1wsIG9yIGlt
YWdlcyBjYW4gaW5zdGFudGx5IGJlIHRyYW5zZm9ybWVkIGludG8gZnVsbHkgYW5pbWF0ZWQgY2hh
cmFjdGVyIHZpZGVvcyB3aXRoIHZvaWNlb3ZlcnNcLCBleHByZXNzaW9uc1wsIGFuZCBzdG9yeXRl
bGxpbmcgYnVpbHQgaW4gYXV0b21hdGljYWxseS5cblxuVGhlc2UgY2hhcmFjdGVyLWRyaXZlbiB2
aWRlb3MgYXJlIGRvbWluYXRpbmcgc29jaWFsIHBsYXRmb3JtcyBiZWNhdXNlIGF1ZGllbmNlcyBj
b25uZWN0IHdpdGggY2hhcmFjdGVycyBmYXIgbW9yZSB0aGFuIG9yZGluYXJ5IGNvbnRlbnRcLCB3
aGljaCBpcyB3aHkgY3JlYXRvcnMgYXJlIGdlbmVyYXRpbmcgbWFzc2l2ZSBlbmdhZ2VtZW50IHVz
aW5nIHRoaXMgZm9ybWF0LlxuXG5EdXJpbmcgdGhpcyBMSVZFIHNlc3Npb25cLCB5b3XigJlsbCBk
aXNjb3Zlcjpcblxu4oCiIEhvdyBBSSBjaGFyYWN0ZXJzIGNhbiBpbnN0YW50bHkgZ2VuZXJhdGUg
ZW5nYWdpbmcgdmlkZW9zIGZvciBUaWtUb2tcLCBJbnN0YWdyYW0gUmVlbHNcLCBhbmQgWW91VHVi
ZSBTaG9ydHNcbuKAoiBUaGUgc2ltcGxlIHdvcmtmbG93IHRoYXQgdHJhbnNmb3JtcyBpZGVhc1ws
IGltYWdlc1wsIG9yIHNjcmlwdHMgaW50byBhbmltYXRlZCB2aXJhbCB2aWRlb3NcbuKAoiBIb3cg
Y2hhcmFjdGVyLWJhc2VkIGNvbnRlbnQgZ3JhYnMgYXR0ZW50aW9uIGFuZCBrZWVwcyB2aWV3ZXJz
IHdhdGNoaW5nIGxvbmdlclxu4oCiIFRoZSBzdHJhdGVneSBiZWhpbmQgdmlyYWwgY2hhcmFjdGVy
IHN0b3J5dGVsbGluZyB0aGF0IGRyaXZlcyBzaGFyZXMgYW5kIGVuZ2FnZW1lbnRcbuKAoiBIb3cg
YmVnaW5uZXJzIGFyZSB1c2luZyBBSSBjaGFyYWN0ZXJzIHRvIGNyZWF0ZSBlbnRlcnRhaW5pbmdc
LCBoaWdobHkgc2hhcmVhYmxlIHZpZGVvcyBhdCBzY2FsZVxuXG5Zb3XigJlsbCBhbHNvIHNlZSBh
IGxpdmUgZGVtbyBzaG93aW5nIGV4YWN0bHkgaG93IHRoZXNlIEFJIGNoYXJhY3RlcnMgY2FuIHNw
ZWFrXCwgcmVhY3RcLCBhbmQgdGVsbCBzdG9yaWVzIHdoaWxlIGF1dG9tYXRpY2FsbHkgc3luY2lu
ZyB2b2ljZVwsIGV4cHJlc3Npb25zXCwgYW5kIHNjZW5lcy5cblxuSWYgeW91IHdhbnQgdG8gbGVh
cm4gaG93IHRoZSBuZXcgd2F2ZSBvZiBBSS1wb3dlcmVkIHZpcmFsIGNoYXJhY3RlciB2aWRlb3Mg
YXJlIGJlaW5nIGNyZWF0ZWTigKZcblxueW91IHdvbuKAmXQgd2FudCB0byBtaXNzIHRoaXMgdHJh
aW5pbmcuXG5cbuKaoO+4jyBJTVBPUlRBTlQg4oCUIFNlY3VyZSBZb3VyIFJlbWluZGVyIE5vdyFc
blxuVGhpcyBpcyBhIGxpdmUgdHJhaW5pbmcgYW5kIHNwYWNlIGlzIGxpbWl0ZWQuXG5cblRvIG1h
a2Ugc3VyZSB5b3UgZG9u4oCZdCBtaXNzIGl0OlxuXG7inIUgQ2xpY2sg4oCcQWRkIHRvIENhbGVu
ZGFy4oCdIGJlbG93IHRvIHNhdmUgdGhlIGV2ZW50IHRvIHlvdXIgR29vZ2xlIC8gT3V0bG9vayBj
YWxlbmRhci5cblxuWW91ciBkZXZpY2Ugd2lsbCBhdXRvbWF0aWNhbGx5IHJlbWluZCB5b3UgYmVm
b3JlIHdlIGdvIGxpdmUuXG5cbk1vc3QgcGVvcGxlIG1pc3MgbGl2ZSB0cmFpbmluZ3Mgc2ltcGx5
IGJlY2F1c2UgdGhleSBmb3JnZXQuXG5cbkRvbuKAmXQgYmUgdGhhdCBwZXJzb24uXG5cbkpvaW4g
ZnJvbSBQQ1wsIE1hY1wsIGlQYWRcLCBvciBBbmRyb2lkOlxuaHR0cHM6Ly96b29tLnVzL3cvOTIy
ODczMjQ0OTM/dGs9aFg0ZmhEQWx1SVdwdVNHTTZ6Nm5RMHBGV2U4QzVMRm9ZN283elJtYmc4ay5E
UWtBQUFBVmZNRFJUUlpOWTI1UVdXZExTRkZOVjNkT05ETlhhamRIYVhkbkFBQUFBQUFBQUFBQUFB
QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUEmdXVpZD1XTl83T1drWDdCeFR3dUtFYUV1dnVs
WXhBXG5cblBob25lIG9uZS10YXA6XG4rMTM0NjI0ODc3OTlcLFwsOTIyODczMjQ0OTMjIFVTIChI
b3VzdG9uKVxuKzEzNjAyMDk1NjIzXCxcLDkyMjg3MzI0NDkzIyBVU1xuXG5Kb2luIHZpYSBhdWRp
bzpcbisxIDM0NiAyNDggNzc5OSBVUyAoSG91c3RvbilcbisxIDM2MCAyMDkgNTYyMyBVU1xuKzEg
Mzg2IDM0NyA1MDUzIFVTXG4rMSA1MDcgNDczIDQ4NDcgVVNcbisxIDU2NCAyMTcgMjAwMCBVU1xu
KzEgNjQ2IDkzMSAzODYwIFVTXG4rMSA2NjkgNDQ0IDkxNzEgVVNcbisxIDY2OSA5MDAgNjgzMyBV
UyAoU2FuIEpvc2UpXG4rMSA2ODkgMjc4IDEwMDAgVVNcbisxIDcxOSAzNTkgNDU4MCBVU1xuKzEg
OTI5IDIwNSA2MDk5IFVTIChOZXcgWW9yaylcbisxIDI1MyAyMDUgMDQ2OCBVU1xuKzEgMjUzIDIx
NSA4NzgyIFVTIChUYWNvbWEpXG4rMSAzMDEgNzE1IDg1OTIgVVMgKFdhc2hpbmd0b24gREMpXG4r
MSAzMDUgMjI0IDE5NjggVVNcbisxIDMwOSAyMDUgMzMyNSBVU1xuKzEgMzEyIDYyNiA2Nzk5IFVT
IChDaGljYWdvKVxuV2ViaW5hciBJRDogOTIyIDg3MzIgNDQ5M1xuSW50ZXJuYXRpb25hbCBudW1i
ZXJzIGF2YWlsYWJsZTogaHR0cHM6Ly96b29tLnVzL3UvYWM5aEVtY1RNVFxuXG5cbg0KTE9DQVRJ
T046aHR0cHM6Ly96b29tLnVzL3cvOTIyODczMjQ0OTM/dGs9aFg0ZmhEQWx1SVdwdVNHTTZ6Nm5R
MHBGV2U4QzVMRm9ZN283elJtYmc4ay5EUWtBQUFBVmZNRFJUUlpOWTI1UVdXZExTRkZOVjNkT05E
TlhhamRIYVhkbkFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUEmdXVp
ZD1XTl83T1drWDdCeFR3dUtFYUV1dnVsWXhBDQpTRVFVRU5DRToxNzczNDIzOTY3DQpPUkdBTkla
RVI7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7Q049Wm9vbSBXZWJpbmFyOm5vLXJlcGx5QHpvb20udXMN
CkFUVEVOREVFO1JPTEU9UkVRLVBBUlRJQ0lQQU5UO0NOPUZyaWVuZDptYWlsdG86bGludXgtaWRl
QHZnZXIua2VybmVsLm9yZw0KQkVHSU46VkFMQVJNDQpUUklHR0VSOi1QVDEwTQ0KQUNUSU9OOkRJ
U1BMQVkNCkRFU0NSSVBUSU9OOlJlbWluZGVyDQpFTkQ6VkFMQVJNDQpFTkQ6VkVWRU5UDQpFTkQ6
VkNBTEVOREFSDQo=
--4aaaef95c0beb83c634d80db861e95afcb4d5cd4a8ebd99978085b85da20--
